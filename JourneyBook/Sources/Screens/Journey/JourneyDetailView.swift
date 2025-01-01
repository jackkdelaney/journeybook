//
//  JourneyDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftUI
import SwiftData

struct JourneyDetailView: View {

    var journey: Journey
    
    @Environment(\.modelContext) var modelContext

    @Query var journeySteps: [JourneyStep]

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
                    try? modelContext.save()
                }
            

            
            Text("\(journeySteps.count)")
            Section("Step 1") {
                if !journey.steps.isEmpty {
                    ForEach(journey.steps) { step in
                        Text("\(step.stepName)")
                    }
                    .onDelete(perform: delete)

                } else {
                    Text("EMPTY")
                }
            }
            .removeListRowPaddingInsets()
        }
        .navigationTitle(journey.journeyName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let journeyStep = journey.steps[offset]
            modelContext.delete(journeyStep)
        }
        do {
            try modelContext.save()
        } catch {}
    }
    
}



/*
 @Query var journeys: [Journey]
 @Environment(\.modelContext) var modelContext
 @EnvironmentObject private var coordinator: Coordinator


 @ViewBuilder
 var body: some View {
     if !journeys.isEmpty {
         Section("Journey's") {
             ForEach(journeys) { journey in
                 Button {
                     coordinator.push(page: .journeyDetails(journey))
                 } label: {
                     VStack(alignment: .leading) {
                         Text("Journey: \(journey.journeyName)")
                             .font(.headline)
                         if let description = journey.journeyDescription {
                             Text(description)
                         }
                     }
                 }
                 .chevronButtonStyle()
             }
             .onDelete(perform: delete)
         }
     }

 }
 */
