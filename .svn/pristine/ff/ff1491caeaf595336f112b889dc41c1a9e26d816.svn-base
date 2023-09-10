import SwiftUI

/**
 View showing history diary entry `brainDump`.
 */
struct HistoryNoteView: View {
    let brainDump: BrainDumpStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        if !String(brainDump.notes).isEmpty {
            Group {
                Divider()
                Text(String(brainDump.notes)).font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
