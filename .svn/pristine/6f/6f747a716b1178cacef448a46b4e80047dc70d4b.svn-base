import SwiftUI

struct PDFAverageMoodView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    var blackAndWhite: Bool = true

    var body: some View {
        HStack {
            Group {
                VStack {
                    // if (data.brainDumps.count == 0) {
                    // Text("Insufficient data")
                    // .font(.caption)
                    // .foregroundColor(.secondary)
                    // } else {
                    // if blackAndWhite {
                    Label("mood_levels", systemImage: "brain.head.profile")
                        .font(.caption)
                        .foregroundColor(.black)
                    // } else {
                    // Label("Mood levels", systemImage: "brain.head.profile")
                    // .font(.caption)
                    // .foregroundColor(.secondary)
                    // }

                    let averageBrainDump = averageBrainDump(
                        timescale: timescale,
                        brainDumps: data.brainDumps)

                    if averageBrainDump != nil {
                        MoodLevelsView(brainDumpFlat: averageBrainDump!,
                                       brainDumpAll: averageBrainDump!,
                                       theme: themes[data.settings.theme],
                                       blackAndWhite: blackAndWhite)
                    } else {
                        VStack(alignment: .center) {
                            Text("insufficient_data")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }

            Group {
                VStack {
                    // if blackAndWhite {
                    Label("volatility", systemImage: "waveform.path.ecg")
                        .font(.caption)
                        .foregroundColor(.black)
                    // } else {
                    // Label("Volatility", systemImage: "waveform.path.ecg")
                    // .font(.caption)
                    // .foregroundColor(.secondary)

                    // }

                    let averageVolatilityBrainDump = averageVolatilityBrainDump(
                        timescale: timescale,
                        brainDumps: data.brainDumps)
                    if averageVolatilityBrainDump != nil {
                        Divider()
                        MoodLevelsView(brainDumpFlat: averageVolatilityBrainDump!,
                                       brainDumpAll: averageVolatilityBrainDump!,
                                       theme: themes[data.settings.theme],
                                       blackAndWhite: blackAndWhite)
                    } else {
                        VStack(alignment: .center) {
                            Text("insufficient_data")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}
