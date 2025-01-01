//
//  JourneyItemsView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftData
import SwiftUI

struct ChevronButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .contentShape(Rectangle())

    }
}

extension View {
    func chevronButtonStyle() -> some View {
        self.buttonStyle(ChevronButtonStyle())
    }
    
    func removeListRowPaddingInsets() -> some View {
        self.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct JourneyItemsView: View {
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
