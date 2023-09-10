import SwiftUI

/**
 Sequence `brainDumps` into chronological array.
 */
@inline(__always) func sequenceBrainDumps(brainDumps: [BrainDumpStruct]) -> [[BrainDumpStruct]] {
    let earliest: Date = getFirstDate(brainDumps: brainDumps)
    let length: Int = Calendar.current.numberOfDaysBetween(from: earliest, to: Date()) + 1
    var sequence: [[BrainDumpStruct]] = Array(repeating: [], count: length)
    
    for brainDump in brainDumps {
        if brainDump.snapType == .mood {
            let offset = length - 1 - Calendar.current.numberOfDaysBetween(from: brainDump.timestamp, to: Date())
            sequence[offset].append(brainDump)
        }
    }
    
    return sequence
}

/**
 Flatten sequence of BrainDumps on a per-day basis.
 */
@inline(__always) func flattenSequence(sequence: [[BrainDumpStruct]]) -> [BrainDumpStruct?] {
    var flattenedSequence: [BrainDumpStruct?] = []
    
    for snaps in sequence {
        let flattened: BrainDumpStruct? = mergeBrainDumps(brainDumps: snaps)
        flattenedSequence.append(flattened)
    }
    
    return flattenedSequence
}

/**
 Generate the complete history of mood levels, moving averages and moving volatilities from `data`.
  */
@inline(__always) func generateHistory(data: DataStoreClass) async -> HistoryStruct {
    var history: HistoryStruct = HistoryStruct()
        
    let flattenedSequencedBrainDumps = data.flattenedSequencedBrainDumps
    let sequencedBrainDumps = data.sequencedBrainDumps
    
    // Mood levels
    for brainDump in flattenedSequencedBrainDumps {
        if brainDump != nil {
            history.levelE.append(brainDump!.elevation)
            history.levelD.append(brainDump!.depression)
            history.levelA.append(brainDump!.anxiety)
            history.levelI.append(brainDump!.irritability)
        } else {
            history.levelE.append(nil)
            history.levelD.append(nil)
            history.levelA.append(nil)
            history.levelI.append(nil)
        }
    }
    
    // Moving averages
    for index in 0..<flattenedSequencedBrainDumps.count {
        let start: Int = max(0, index - data.settings.slidingWindowSize + 1)
        let brainDumps: [BrainDumpStruct?] = Array(flattenedSequencedBrainDumps[start...index])
        let averages: [CGFloat?] = average(brainDumps: brainDumps)
        
        history.averageE.append(averages[0])
        history.averageD.append(averages[1])
        history.averageA.append(averages[2])
        history.averageI.append(averages[3])
    }
    
    // Moving volatilities
    for index in 0..<sequencedBrainDumps.count {
        let start: Int = max(0, index - data.settings.slidingWindowSize + 1)
        let brainDumps: [BrainDumpStruct?] = Array(sequencedBrainDumps[start...index].joined())
        let volatilities = volatility(brainDumps: brainDumps)
        
        history.volatilityE.append(volatilities[0])
        history.volatilityD.append(volatilities[1])
        history.volatilityA.append(volatilities[2])
        history.volatilityI.append(volatilities[3])
    }
        
    return history
}

/**
 Generate a binary timeline baed on a sequence of dates.
 `nil` where there is no `date`, `1` otherwise.
 */
@inline(__always) func generateTimelineForDates(brainDumps: [BrainDumpStruct], dates: [Date]) -> [CGFloat?] {
    let earliest: Date = getFirstDate(brainDumps: brainDumps)
    let length: Int = Calendar.current.numberOfDaysBetween(from: earliest, to: Date()) + 1
    var timeline: [CGFloat?] = Array(repeating: nil, count: length)
    
    for date in dates {
        let offset = max(0, length - 1 - Calendar.current.numberOfDaysBetween(from: date, to: Date())) // hack
        timeline[offset] = 1
    }
    
    return timeline
}
