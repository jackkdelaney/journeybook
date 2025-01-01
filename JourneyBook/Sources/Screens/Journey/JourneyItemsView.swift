//
//  JourneyItemsView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftData
import SwiftUI

struct JourneyItemsView: View {
    @Query var journeys: [Journey]
    @Environment(\.modelContext) var modelContext

    @ViewBuilder
    var body: some View {
        if !journeys.isEmpty {
            Section("Journey's") {
                ForEach(journeys) { journey in
                    VStack(alignment: .leading) {
                        Text("Journey: \(journey.journeyName)")
                            .font(.headline)
                        if let description = journey.journeyDescription {
                            Text(description)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
        }

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
