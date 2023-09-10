import SwiftUI

/**
 View showing average mood over `timescale`.
 */
struct AverageMoodView: View {
    var timescale: Int
    @EnvironmentObject var data: DataStoreClass
    var blackAndWhite: Bool = false
    var showTrend: Bool = false

    var body: some View {
        let (averageBrainDumpFlat, averageBrainDumpAll) = getByTimescale(levels: data.processedData.averageMood, timescale: timescale)
        let (_, averageVolatilityBrainDumpAll) = getByTimescale(levels: data.processedData.averageVolatility, timescale: timescale)
        
        if data.brainDumps.count == 0 {
            Spacer()
            Text("insufficient_data")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            if blackAndWhite {
                Label("mood_levels", systemImage: "brain.head.profile")
                    .font(.caption)
                    .foregroundColor(.black)
            } else {
                Label("mood_levels", systemImage: "brain.head.profile")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if averageBrainDumpFlat != nil && averageBrainDumpAll != nil {
                MoodLevelsView(brainDumpFlat: averageBrainDumpFlat!,
                               brainDumpAll: averageBrainDumpAll!,
                               theme: themes[data.settings.theme],
                               blackAndWhite: blackAndWhite,
                               double: true)
            } else {
                VStack(alignment: .center) {
                    Text("insufficient_data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if blackAndWhite {
                Label("volatility", systemImage: "waveform.path.ecg")
                    .font(.caption)
                    .foregroundColor(.black)
            } else {
                Label("volatility", systemImage: "waveform.path.ecg")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            if averageVolatilityBrainDumpAll != nil {
                MoodLevelsView(brainDumpFlat: averageVolatilityBrainDumpAll!,
                               brainDumpAll: averageVolatilityBrainDumpAll!,
                               theme: themes[data.settings.theme],
                               blackAndWhite: blackAndWhite,
                               double: false)
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("insufficient_data")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            if showTrend {
                Label("One_week_trend", systemImage: "chart.line.uptrend.xyaxis")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                TrendsView()
            }
        }
    }
}
