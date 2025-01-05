//
//  JourneyItemsView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftData
import SwiftUI

struct ChevronButtonStyle: ButtonStyle {
    let compact : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if compact {
                configuration.label
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.secondary)
            } else {
                configuration.label
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .contentShape(Rectangle())
    }
}

extension View {
    func chevronButtonStyle(compact : Bool = false) -> some View {
        buttonStyle(ChevronButtonStyle(compact : compact))
    }

    func removeListRowPaddingInsets() -> some View {
        listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
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
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(journey.dateCreated.formatted())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            
                            if let description = journey.journeyDescription {
                                Text(description)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            }
                        }
                    }
                    .chevronButtonStyle(compact: true)
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
