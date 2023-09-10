import SwiftUI

/**
 View showing history event `brainDump`.
 */
struct HistoryEventView: View {
    let brainDump: BrainDumpStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        Group {
            VStack(alignment: .center) {
                Divider()
                Spacer()
                    .frame(height: 10)
                Text(String(brainDump.event))
                    .font(.caption)
                    .fontWeight(.bold)

                if !String(brainDump.notes).isEmpty {
                    Divider()
                    Text(String(brainDump.notes)).font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
