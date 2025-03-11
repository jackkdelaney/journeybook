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
    @EnvironmentObject private var coordinator: Coordinator

    @Binding var sheet: JourneySheet?

    @ViewBuilder
    var body: some View {
        if !journeys.isEmpty {
            Section("Journey's") {
                ForEach(journeys) { journey in
                    Button {
                        coordinator.push(page: .journeyDetails(journey))
                    } label: {
                        VStack(alignment: .leading) {
                            Text("\(journey.journeyName)")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(journey.dateCreated.formatted())
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if let description = journey.journeyDescription {
                                Text(description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .chevronButtonStyle(compact: true)
                    .contextMenu {
                        Button {
                            sheet = .editJourney(journey)
                        } label: {
                            Label("Edit", systemImage: "pencil")
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
            for step in journey.steps {
                modelContext.delete(step)
            }
            modelContext.delete(journey)
        }
        do {
            try modelContext.save()
        } catch {}
    }
}
