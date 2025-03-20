//
//  JourneyDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftUI

struct JourneyDetailView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.editMode) private var editMode

    @Environment(\.accessibilityAssistiveAccessEnabled) private var isAssistiveAccessEnabled

    @Bindable var journey: Journey

    @State private var sheet: JourneyStepSheet? = nil

    var body: some View {
        Form {
            Section {
                if !isEditing {
                    
                    AddNewJourneyStepButton(journey: journey, sheet: $sheet)
                } else {
                    Button("Edit Title and Description") {
                        sheet = .editJourney(journey)
                    }
                }
                }
            .animation(nil, value: editMode?.wrappedValue)

            Section("Description") {
                if let description = journey.journeyDescription {
                    Text(description)
                } else {
                    Text("No Description")
                }
            }

            if !journey.steps.isEmpty {
                Section("Step's") {
                    ForEach(sortedJourneySteps) { step in
                        Button {
                            coordinator.push(page: .journeyStepDetails(step))
                        } label: {
                            HStack {
                                Text("#\(step.orderIndex)")
                                    .fontWeight(.heavy)
                                VStack {
                                    Text("\(step.stepName)")
                                    if let stepDescription = step.stepDescription {
                                        Text("\(stepDescription)")
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .chevronButtonStyle()
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            } else {
                Section {
                    ContentUnavailableView(
                        "No Steps",
                        systemImage: "circle.slash",
                        description: Text("You currently don't have any steps for this journey.")
                    )
                    .removeListRowPaddingInsets()
                }
            }
        }
        .navigationTitle(journey.journeyName)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {

                EditButton()
            }
        }
    }

    var sortedJourneySteps: [JourneyStep] {
        journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
    }

    func move(fromOffsets from: IndexSet, toOffset to: Int) {
        var sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
        sortedLocalList.move(fromOffsets: from, toOffset: to)
        for (index, item) in sortedLocalList.enumerated() {
            item.orderIndex = index
        }

        do {
            try modelContext.save()
        } catch {}
    }

    func delete(at offsets: IndexSet) {
        let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })

        for offset in offsets {
            let journeyStep = sortedLocalList[offset]
            modelContext.delete(journeyStep)
        }
        do {
            try modelContext.save()
        } catch {}
    }

    var isEditing: Bool {
        if let editMode = editMode {
            return editMode.wrappedValue.isEditing
        }
        return false
    }
}
