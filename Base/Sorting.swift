import SwiftUI

/**
 Sort `brainDumps` by their date `timestamp`.
 */
@inline(__always) func sortByDate(brainDumps: [BrainDumpStruct]) -> [BrainDumpStruct] {
    return brainDumps.sorted(by: { $0.timestamp > $1.timestamp })
}

/**
 Sort `healthSnaps` by their date `timestamp`.
 */
@inline(__always) func sortByDate(healthSnaps: [HealthSnapStruct]) -> [HealthSnapStruct] {
    return healthSnaps.sorted(by: { $0.timestamp > $1.timestamp })
}
