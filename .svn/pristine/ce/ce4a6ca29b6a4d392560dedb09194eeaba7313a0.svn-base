import SwiftUI

/**
 View showing history media `brainDump`.
 */
struct HistoryMediaView: View {
    let brainDump: BrainDumpStruct
    @EnvironmentObject var data: DataStoreClass

    var body: some View {
        Group {
            Divider()
            Spacer()
            if let image = UIImage.loadImageFromDiskWith(fileName: brainDump.id.uuidString) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
