import SwiftUI

/**
 Calculate the average of `data`, nil if no data.
 */
@inline(__always) func average(data: [CGFloat?]) -> CGFloat? {
    var sum: CGFloat = 0
    var count: CGFloat = 0

    for value in data {
        if value != nil {
            sum += value!
            count += 1
        }
    }

    if count > 0 {
        return sum / count
    } else {
        return nil
    }
}

/**
 Average `type` of `healthSnaps`
 */
@inline(__always) func average(healthSnaps: [HealthSnapStruct], type: HealthTypeEnum) -> CGFloat? {
    var data: [CGFloat?] = []
    
    for healthSnap in healthSnaps {
        switch type {
        case .all:
            break
        case .weight:
            data.append(healthSnap.weight)
        case .distance:
            data.append(healthSnap.walkingRunningDistance)
        case .sleep:
            data.append(healthSnap.sleepHours)
        case .menstrual:
            data.append(healthSnap.menstrual)
        case .energy:
            data.append(healthSnap.activeEnergy)
        }
    }
    
    return average(data: data)
}

/**
 Calculate the joint average of `dataX` and `dataY`, nil if no data.
 */
@inline(__always) func average(dataX: [CGFloat?], dataY: [CGFloat?]) -> CGFloat? {
    var sum: CGFloat = 0
    var count: CGFloat = 0

    for i in 0 ..< dataX.count {
        if dataX[i] != nil && dataY[i] != nil {
            sum += dataX[i]! * dataY[i]!
            count += 1
        }
    }

    if count > 0 {
        return sum / count
    } else {
        return nil
    }
}

/**
 Calculate the mood averages of `brainDumps`, nil if no data.
 */
@inline(__always) func average(brainDumps: [BrainDumpStruct?]) -> [CGFloat?] {
    var dataE: [CGFloat] = []
    var dataD: [CGFloat] = []
    var dataA: [CGFloat] = []
    var dataI: [CGFloat] = []

    for brainDump in brainDumps {
        if brainDump != nil {
            if brainDump!.snapType == .mood {
                dataE.append(brainDump!.elevation)
                dataD.append(brainDump!.depression)
                dataA.append(brainDump!.anxiety)
                dataI.append(brainDump!.irritability)
            }
        }
    }

    let averageE = average(data: dataE)
    let averageD = average(data: dataD)
    let averageA = average(data: dataA)
    let averageI = average(data: dataI)

    return [averageE, averageD, averageA, averageI]
}

/**
 Generate an average series from an array of `series`.
 */
@inline(__always) func averageSeries(series: [[CGFloat?]]) -> [CGFloat?] {
    if series.count == 0 {
        return []
    }

    var newSeries: [CGFloat?] = []

    for index in 0 ..< series[0].count {
        var theseVals: [CGFloat?] = []
        for whichSeries in series {
            theseVals.append(whichSeries[index])
        }
        let thisAverage = average(data: theseVals)
        newSeries.append(thisAverage)
    }

    return newSeries
}
