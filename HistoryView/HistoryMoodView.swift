import SwiftUI

/**
 View showing a history `brainDump` entry.
 */
struct HistoryMoodView: View {
    let brainDump: BrainDumpStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        Divider()
        MoodLevelsView(brainDumpFlat: brainDump, brainDumpAll: brainDump, theme: themes[data.settings.theme])

        Group {
            if totalSymptoms(brainDump: brainDump, settings: data.settings) != 0 {
                Divider()
                Label("symptoms", systemImage: "heart.text.square")
                    .font(.caption)
                    .foregroundColor(.secondary)
                HistorySymptomsView(brainDump: brainDump)
            }
        }

        Group {
            if totalActivities(brainDump: brainDump, settings: data.settings) != 0 {
                Divider()
                Label("activity", systemImage: "figure.walk")
                    .font(.caption)
                    .foregroundColor(.secondary)
                HistoryActivityView(brainDump: brainDump)
            }
        }

        Group {
            if totalSocial(brainDump: brainDump, settings: data.settings) != 0 {
                Divider()
                Label("social", systemImage: "person.2")
                    .font(.caption)
                    .foregroundColor(.secondary)
                HistorySocialView(brainDump: brainDump)
            }
        }

        if !String(brainDump.notes).isEmpty {
            Group {
                Divider()
                Text(String(brainDump.notes))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
