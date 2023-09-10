import SwiftUI

/**
 View showing `brainDump` history item with `filter` based on `searchText`.
 */
struct HistoryItemView: View {
    var brainDump: BrainDumpStruct
    @Binding var filter: SnapTypeEnum
    @Binding var searchText: String
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State private var showingDeleteAlert: Bool = false
    @State private var showingBrainDumpSheet: Bool = false

    var body: some View {
        if snapFilter(brainDump: brainDump, filter: filter, searchText: searchText) && !(brainDump.snapType == .quote && !data.settings.quoteVisibility) {
            GroupBox {
                Group {
                    HStack {
                        if brainDump.snapType == .mood {
                            Label(brainDump.timestamp.dateTimeString(), systemImage: "brain.head.profile")
                                .font(.caption)
                        }
                        if brainDump.snapType == .note {
                            Label(brainDump.timestamp.dateTimeString(), systemImage: "note.text")
                                .font(.caption)
                        }
                        if brainDump.snapType == .event {
                            Label(brainDump.timestamp.dateTimeString(), systemImage: "star.fill")
                                .font(.caption)
                        }
                        if brainDump.snapType == .media {
                            Label(brainDump.timestamp.dateTimeString(), systemImage: "photo.on.rectangle.angled")
                                .font(.caption)
                        }
                        if brainDump.snapType == .custom {
                            Label(brainDump.timestamp.dateTimeString(), systemImage: "eye")
                                .font(.caption)
                        }
                        if brainDump.snapType == .quote && data.settings.quoteVisibility {
                            Label(brainDump.timestamp.dateTimeString(), systemImage: "quote.opening")
                                .labelStyle(.iconOnly)
                                .font(.caption)
                        }

                        Spacer()
                        Menu {
                            if brainDump.snapType == .mood || brainDump.snapType == .note || brainDump.snapType == .event {
                                Button(action: {
                                    showingBrainDumpSheet.toggle()
                                }, label: {
                                    Image(systemName: "pencil")
                                    Text("edit")
                                })
                            }

                            Button(role: .destructive, action: {
                                showingDeleteAlert = true
                            }, label: {
                                Image(systemName: "trash")
                                Text("delete")
                            })
                        } label: { Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.primary)
                        }
                        .sheet(isPresented: $showingBrainDumpSheet) {
                            switch brainDump.snapType {
                            case .mood:
                                BrainDumpView(brainDump: brainDump)
                            case .event:
                                EventView(brainDump: brainDump)
                            case .note:
                                NoteView(brainDump: brainDump)
                            case .media:
                                MediaView(brainDump: brainDump)
                            default:
                                EmptyView()
                            }
                        }
                        .alert(isPresented: $showingDeleteAlert) {
                            Alert(
                                title: Text("delete_this_brainDump"),
                                message: Text("sure_to_delete"),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(
                                    Text("delete"),
                                    action: {
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                data.stopProcessing()
                                                health.stopProcessing(data: data)
                                                data.brainDumps = deleteHistoryItem(brainDumps: data.brainDumps, brainDump: brainDump)
                                                data.startProcessing()
                                                health.startProcessing(data: data)
                                            }
                                        }
                                    }
                                )
                            )
                        }
                    }
                }

                Group {
                    if brainDump.snapType == .event {
                        HistoryEventView(brainDump: brainDump)
                    }
                    if brainDump.snapType == .mood {
                        HistoryMoodView(brainDump: brainDump)
                    }
                    if brainDump.snapType == .note {
                        HistoryNoteView(brainDump: brainDump)
                    }
                    if brainDump.snapType == .media {
                        HistoryMediaView(brainDump: brainDump)
                    }
                    if brainDump.snapType == .custom {
                        HistoryCustomView(which: brainDump.customView)
                    }
                    if brainDump.snapType == .quote && data.settings.quoteVisibility {
                        HistoryQuoteView(brainDump: brainDump)
                    }
                }
            }
            .padding([.leading, .trailing], 7)
            .padding(.bottom, -2)
        }
    }
}
