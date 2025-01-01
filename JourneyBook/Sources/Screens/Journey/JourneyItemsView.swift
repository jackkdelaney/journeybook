//
//  JourneyItemsView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftUI
import SwiftData

struct JourneyItemsView: View {
    @Query var journeys: [Journey]
    @Environment(\.modelContext) var modelContext
    
    @ViewBuilder
    var body: some View {
        Text("HOWDY0")
        Text("\(journeys.count)")
        Button("ADD") {
            let journey = Journey(journeyName: "Journey \(journeys.count)")
            modelContext.insert(journey)
            do {
                print("TRY")
                try modelContext.save()
                print("DONE")

            } catch {
                fatalError(error.localizedDescription)
            }
        }
        ForEach(journeys) { journey in
            HStack {
                Text("Journey: \(journey.journeyName)")
                if let description = journey.journeyDescription {
                    Text(description)
                }
            }
        }
        .onDelete(perform: delete)
    }
    
   
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let journey = journeys[offset]
            modelContext.delete(journey)
        }
        do {
            try modelContext.save()
        } catch {}
    }
}
