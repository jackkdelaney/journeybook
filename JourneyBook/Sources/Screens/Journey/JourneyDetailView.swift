//
//  JourneyDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftUI

struct JourneyDetailView: View {

    var journey: Journey
    
    @Environment(\.modelContext) var modelContext

    
    var sortedJourneySteps: [JourneyStep] {
        journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
    }
    
    private func order() {
        let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
        for (index, item) in sortedLocalList.enumerated() {
            item.orderIndex = index
        }
    }

    var body: some View {
        Form {
            if let description = journey.journeyDescription {
                Text(description)
            } else {
                Text("No Description")
            }
                Button("Add New Phrase [Directly]"){
                    let randomInt = Int.random(in: 1..<5)

                    let step = JourneyStep(stepName: "Hello!! \(randomInt)",journey: journey)
                    modelContext.insert(step)
                    order()
                    try? modelContext.save()
                }
            

            Section("Step 1") {
                if !journey.steps.isEmpty {
                    ForEach(sortedJourneySteps) { step in // .sorted(by: .orderIndex)
                        VStack {
                            Text("\(step.stepName)")
                                .font(.headline)
                            Text("\(step.orderIndex)")
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)


                } else {
                    Text("EMPTY")
                }
            }
            .removeListRowPaddingInsets()
        }
        .navigationTitle(journey.journeyName)
        .navigationBarTitleDisplayMode(.inline)
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
