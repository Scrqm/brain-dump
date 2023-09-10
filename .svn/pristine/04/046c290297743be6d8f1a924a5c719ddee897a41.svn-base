import SwiftUI

/**
 Return a `BrainDumpStruct` of the average of those in a given `timescale`.
 */
@inline(__always) func averageBrainDump(timescale: Int, brainDumps: [BrainDumpStruct], flatten: Bool = true) -> BrainDumpStruct? {
    let windowSnaps = getBrainDumpsByDateWindow(brainDumps: brainDumps,
                                               date: Date(),
                                               windowStart: -timescale,
                                               windowEnd: 0,
                                               flatten: flatten)
    let average: [CGFloat?] = average(brainDumps: windowSnaps)

    if (average[0] == nil) || (average[1] == nil) || (average[2] == nil) || (average[3] == nil) {
        return nil
    } else {
        var averageBrainDump = BrainDumpStruct()
        averageBrainDump.elevation = average[0]!
        averageBrainDump.depression = average[1]!
        averageBrainDump.anxiety = average[2]!
        averageBrainDump.irritability = average[3]!
        return averageBrainDump
    }
}

/**
 Return a `BrainDumpStruct` of the volatility of those in a given `timescale`.
 */
@inline(__always) func averageVolatilityBrainDump(timescale: Int, brainDumps: [BrainDumpStruct]) -> BrainDumpStruct? {
    let windowSnaps = getBrainDumpsByDateWindow(brainDumps: brainDumps,
                                               date: Date(),
                                               windowStart: -timescale,
                                               windowEnd: 0,
                                               flatten: false)
    let volatility: [CGFloat?] = volatility(brainDumps: windowSnaps)

    if (volatility[0] == nil) || (volatility[1] == nil) || (volatility[2] == nil) || (volatility[3] == nil) {
        return nil
    } else {
        var averageVolatilityBrainDump = BrainDumpStruct()
        averageVolatilityBrainDump.elevation = 2 * volatility[0]!
        averageVolatilityBrainDump.depression = 2 * volatility[1]!
        averageVolatilityBrainDump.anxiety = 2 * volatility[2]!
        averageVolatilityBrainDump.irritability = 2 * volatility[3]!
        return averageVolatilityBrainDump
    }
}
