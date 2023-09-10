import SwiftUI

/**
 View for photo diary sheet.
 */
struct MediaView: View {
    @Environment(\.dismiss) var dismiss
    @State var brainDump: BrainDumpStruct
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State var image: UIImage? = nil

    var body: some View {
        GroupBox {
            HStack {
                Label(brainDump.timestamp.dateTimeString(), systemImage: "clock").font(.caption)
                Spacer()
                Button {
                } label: { Image(systemName: "calendar.badge.clock").resizable().scaledToFill().frame(width: 15, height: 15).foregroundColor(Color.primary) }
            }

            ImagePicker(sourceType: .camera, selectedImage: $image)
                .onDisappear(perform: {
                    if image != nil {
                        DispatchQueue.main.async {
                            withAnimation {
                                brainDump.snapType = .media
                                image!.saveImage(imageName: brainDump.id.uuidString)
                                if data.settings.saveMediaToCameraRoll {
                                    UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                                }
                                data.stopProcessing()
                                health.stopProcessing(data: data)
                                data.brainDumps = deleteHistoryItem(brainDumps: data.brainDumps, brainDump: brainDump)
                                data.brainDumps.append(brainDump)
                                data.startProcessing()
                                health.startProcessing(data: data)
                            }
                        }
                        dismiss()
                    }
                })
        }
    }
}
