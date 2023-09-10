import SwiftUI

/**
 View showing history quote `brainDump`.
 */
struct HistoryQuoteView: View {
    let brainDump: BrainDumpStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        Group {
            VStack(alignment: .center) {
                Spacer()
                Divider()
                Spacer()
                    .frame(height: 10)
                Text(.init(brainDump.notes))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
