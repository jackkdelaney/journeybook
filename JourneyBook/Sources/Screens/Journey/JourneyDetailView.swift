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

    @Bindable var journey: Journey
    
    
    @State private var sheet: JourneyStepSheet? = nil



    var body: some View {
        Form {
            Section {
                AddNewJourneyStepButton(journey : journey, sheet: $sheet)
            }
            if let description = journey.journeyDescription {
                Text(description)
            } else {
                Text("No Description")
            }

            Section("Step (Temp Section)") {
                if !journey.steps.isEmpty {
                    ForEach(sortedJourneySteps) { step in
                        Button {
                            coordinator.push(page: .journeyStepDetails(step))
                        }label: {
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


                } else {
                    Text("EMPTY")
                }
            }
        }
        .navigationTitle(journey.journeyName)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                EditButton()
            }
        }
    }
    
    var sortedJourneySteps: [JourneyStep] {
        journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
    }
    
    private func order() {
        let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
        for (index, item) in sortedLocalList.enumerated() {
            item.orderIndex = index
        }
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
    
}
