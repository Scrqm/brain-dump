import SwiftUI

/**
 Does `brainDump` satisfy the given filtering constriants?
 */
@inline(__always) func snapFilter(brainDump: BrainDumpStruct, filter: SnapTypeEnum, searchText: String) -> Bool {
    let filterOutcome =
    (filter == .mood && brainDump.snapType == .mood) ||
    (filter == .event && brainDump.snapType == .event) ||
    (filter == .note && brainDump.snapType == .note) ||
    (filter == .media && brainDump.snapType == .media) ||
    filter == .none

    if filterOutcome {
        if searchText == "" { return true }
        
        let eventTextOutcome = brainDump.event.lowercased().contains(searchText.lowercased())
        let notesTextOutcome = brainDump.notes.lowercased().contains(searchText.lowercased())

        if (eventTextOutcome || notesTextOutcome) { return true }
    }

    return false
}

/**
 Returns the earliest `Date` amongst `brainDumps`.
 */
@inline(__always) func getFirstDate(brainDumps: [BrainDumpStruct]) -> Date {
    var firstDate = Date().startOfDay()
    for brainDump in brainDumps {
        if brainDump.timestamp < firstDate {
            if brainDump.snapType == .mood || brainDump.snapType == .note || brainDump.snapType == .event || brainDump.snapType == .media {
                firstDate = brainDump.timestamp
            }
        }
    }
    return firstDate
}

/**
 Returns the most recent `Date` amongst `brainDumps`.
 */
@inline(__always) func getLastDate(brainDumps: [BrainDumpStruct]) -> Date {
    var lastDate = Date().endOfDay()
    for brainDump in brainDumps {
        if brainDump.timestamp > lastDate {
            lastDate = brainDump.timestamp
        }
    }
    return lastDate
}

/**
 Returns an array of elements from `brainDumps` that coincide with the same day of `date`. The optional `flatten` parameter merges them into their single day equivalent.
 */
@inline(__always) func getBrainDumpsByDate(brainDumps: [BrainDumpStruct], date: Date, flatten: Bool = false) -> [BrainDumpStruct] {
    var filtered: [BrainDumpStruct] = []
    let dateComponents = date.getComponents()
    for brainDump in brainDumps {
        if brainDump.timestamp.getComponents() == dateComponents {
            if brainDump.snapType == .mood {
                filtered.append(brainDump)
            }
        }
    }
    if flatten {
        if filtered.count > 0 {
            filtered = [mergeBrainDumps(brainDumps: filtered)!]
        }
    }
    return filtered
}

@inline(__always) func getBrainDumpsByDate(data: DataStoreClass, date: Date, flatten: Bool = false) -> [BrainDumpStruct] {
    let sequenced: [[BrainDumpStruct]] = data.sequencedBrainDumps
    let flattened: [BrainDumpStruct?] = data.flattenedSequencedBrainDumps
    let offset = Calendar.current.numberOfDaysBetween(from: date, to: Date())
    
    if offset < 0 || offset >= flattened.count {
        return []
    }
    
    if flatten {
        if flattened[offset] == nil {
            return []
        } else {
            return [flattened[offset]!]
        }
    } else {
        return sequenced[offset]
    }
}

/**
 Returns an array of elements from `healthSnaps` that coincide with the same day of `date`. The optional `flatten` parameter merges them into their single day equivalent.
 */
@inline(__always) func getHealthSnapsByDate(healthSnaps: [HealthSnapStruct], date: Date, flatten: Bool = false) -> [HealthSnapStruct] {
    var filtered: [HealthSnapStruct] = []
    let dateComponents = date.getComponents()
    for healthSnap in healthSnaps {
        if healthSnap.timestamp.getComponents() == dateComponents {
            filtered.append(healthSnap)
        }
    }
    if flatten {
        if filtered.count > 0 {
            filtered = [mergeHealthSnaps(healthSnaps: filtered)!]
        }
    }
    return filtered
}

/**
 Returns an array of elements from `brainDumps` that sit within a window of `windowStart` and `windowEnd` days after `date`. The optional `flatten` parameter merges them into their single day equivalents on a per-day basis.
 */
@inline(__always) func getBrainDumpsByDateWindow(brainDumps: [BrainDumpStruct], date: Date, windowStart: Int, windowEnd: Int, flatten: Bool = false) -> [BrainDumpStruct] {
    var filtered: [BrainDumpStruct] = []
    var theseBrainDumps: [BrainDumpStruct?]
    
    if flatten {
        theseBrainDumps = flattenSequence(sequence: sequenceBrainDumps(brainDumps: brainDumps))
    } else {
        theseBrainDumps = brainDumps
    }
    
    let startDate = date.addDays(days: windowStart).startOfDay()
    let endDate = date.addDays(days: windowEnd).endOfDay()
    
    for brainDump in theseBrainDumps {
        if brainDump != nil {
            if brainDump!.timestamp >= startDate && brainDump!.timestamp <= endDate {
                if brainDump!.snapType == .mood {
                    filtered.append(brainDump!)
                }
            }
        }
    }
    
    return filtered
}

@inline(__always) func getBrainDumpsByDateWindow(data: DataStoreClass, date: Date, windowStart: Int, windowEnd: Int, flatten: Bool = false) -> [BrainDumpStruct] {
    let offset = Calendar.current.numberOfDaysBetween(from: date, to: Date())
    var brainDumps: [BrainDumpStruct] = []

    for i in (offset+windowStart)...(offset+windowEnd) {
        let thisDate = date.addDays(days: i)
        let theseSnaps = getBrainDumpsByDate(data: data, date: thisDate, flatten: flatten)
        brainDumps += theseSnaps
    }

    return brainDumps
}

/**
 Does `string` contain `hashtag`.
 */
@inline(__always) func containsHashtag(string: String, hashtag: String) -> Bool {
    let hashtags = getHashtags(string: string.lowercased())
    let result = hashtags.contains(hashtag)
    return result
}
