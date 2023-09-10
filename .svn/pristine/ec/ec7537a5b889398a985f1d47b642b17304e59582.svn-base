import SwiftUI

/**
 View for BrainDump sheet.
 */
struct BrainDumpView: View {
    @Environment(\.dismiss) var dismiss
    @State var brainDump: BrainDumpStruct
    @EnvironmentObject var data: DataStoreClass
    @EnvironmentObject var health: HealthManager
    @State private var showingDatePickerSheet = false

    var body: some View {
        GroupBox {
            ScrollView {
                Group {
                    HStack {
                        Label(brainDump.timestamp.dateTimeString(), systemImage: "clock")
                            .font(.caption)

                        Spacer()

                        Button {
                            showingDatePickerSheet.toggle()
                        } label: { Image(systemName: "calendar.badge.clock")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.primary)
                        }.sheet(isPresented: $showingDatePickerSheet) {
                            DatePickerView(brainDump: $brainDump, settings: data.settings)
                        }
                    }
                }

                // Mood
                Group {
                    Divider()
                    VStack(spacing: themes[data.settings.theme].sliderSpacing) {
                        Label("mood", systemImage: "brain.head.profile").font(.caption)
                        Spacer()
                            .frame(height: 20)
                        Text("elevation")
                            .font(Font.caption.bold())
                            .foregroundColor(themes[data.settings.theme].elevationColor)
                        Slider(value: $brainDump.elevation, in: 0 ... 4, step: 1)
                            .onChange(of: brainDump.elevation) { _ in
                                hapticResponseLight(data: data)
                            }
                        Text("depression")
                            .font(Font.caption.bold())
                            .foregroundColor(themes[data.settings.theme].depressionColor)
                        Slider(value: $brainDump.depression, in: 0 ... 4, step: 1)
                            .onChange(of: brainDump.depression) { _ in
                                hapticResponseLight(data: data)
                            }
                        Text("anxiety")
                            .font(Font.caption.bold())
                            .foregroundColor(themes[data.settings.theme].anxietyColor)
                        Slider(value: $brainDump.anxiety, in: 0 ... 4, step: 1)
                            .onChange(of: brainDump.anxiety) { _ in
                                hapticResponseLight(data: data)
                            }
                        Text("irritability")
                            .font(Font.caption.bold())
                            .foregroundColor(themes[data.settings.theme].irritabilityColor)
                        Slider(value: $brainDump.irritability, in: 0 ... 4, step: 1)
                            .onChange(of: brainDump.irritability) { _ in
                                hapticResponseLight(data: data)
                            }
                    }
                }

                // Symptoms
                if visibleSymptomsCount(settings: data.settings) > 0 {
                    Group {
                        Divider()
                        Label("symptoms", systemImage: "heart.text.square").font(.caption)

                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

                        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].brainDumpGridSpacing) {
                            ForEach(0 ..< symptomList.count, id: \.self) { i in
                                if data.settings.symptomVisibility[i] {
                                    Toggle(.init(symptomList[i]), isOn: $brainDump.symptoms[i])
                                        .toggleStyle(.button)
                                        .tint(themes[data.settings.theme].buttonColor)
                                        .font(.caption)
                                        .padding(1)
                                        .onChange(of: brainDump.symptoms[i]) { _ in
                                            hapticResponseLight(data: data)
                                        }
                                }
                            }
                        }
                    }
                }

                // Activities
                if visibleActivitiesCount(settings: data.settings) > 0 {
                    Group {
                        Divider()
                        Label("activity", systemImage: "figure.walk").font(.caption)

                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

                        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].brainDumpGridSpacing) {
                            ForEach(0 ..< activityList.count, id: \.self) { i in
                                if data.settings.activityVisibility[i] {
                                    Toggle(.init(activityList[i]), isOn: $brainDump.activities[i])
                                        .toggleStyle(.button)
                                        .tint(themes[data.settings.theme].buttonColor)
                                        .font(.caption)
                                        .onChange(of: brainDump.activities[i]) { _ in
                                            hapticResponseLight(data: data)
                                        }
                                }
                            }
                        }
                    }
                }

                // Social
                if visibleSocialCount(settings: data.settings) > 0 {
                    Group {
                        Divider()
                        Label("social", systemImage: "person.2").font(.caption)

                        let gridItemLayout = Array(repeating: GridItem(.flexible()), count: data.settings.numberOfGridColumns)

                        LazyVGrid(columns: gridItemLayout, spacing: themes[data.settings.theme].brainDumpGridSpacing) {
                            ForEach(0 ..< socialList.count, id: \.self) { i in
                                if data.settings.socialVisibility[i] {
                                    Toggle(.init(socialList[i]), isOn: $brainDump.social[i])
                                        .toggleStyle(.button)
                                        .tint(themes[data.settings.theme].buttonColor)
                                        .font(.caption)
                                        .onChange(of: brainDump.social[i]) { _ in
                                            hapticResponseLight(data: data)
                                        }
                                }
                            }
                        }
                    }
                }

                // Notes
                Group {
                    VStack {
                        Divider()
                        Label("notes", systemImage: "note.text").font(.caption)
                        TextEditor(text: $brainDump.notes)
                            .font(.caption)
                            .frame(minHeight: 50, alignment: .leading)
                    }
                }

                // Save button
                Button {
                    hapticResponseLight(data: data)
                    DispatchQueue.main.async {
                        withAnimation {
                            data.stopProcessing()
                            health.stopProcessing(data: data)
                            brainDump.snapType = .mood
                            data.brainDumps = deleteHistoryItem(brainDumps: data.brainDumps, brainDump: brainDump)
                            data.brainDumps.append(brainDump)
                            data.settings.addedSnaps += 1
                            let quoteSnap = getQuoteSnap(count: data.settings.addedSnaps)
                            if quoteSnap != nil {
                                data.brainDumps.append(quoteSnap!)
                            }
                            data.startProcessing()
                            health.startProcessing(data: data)
                        }
                    }
                    dismiss()
                } label: { Image(systemName: "arrowtriangle.right.circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(themes[data.settings.theme].buttonColor)
                    .frame(width: themes[data.settings.theme].controlBigIconSize, height: themes[data.settings.theme].controlBigIconSize)
                }
            }
        }
    }
}
