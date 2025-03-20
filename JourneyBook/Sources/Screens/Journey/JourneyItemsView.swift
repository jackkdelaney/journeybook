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
    
    @Environment(\.accessibilityAssistiveAccessEnabled) private var isAssistiveAccessEnabled


    @Binding var sheet: JourneySheet?

    @Binding var searchText: String

    @ViewBuilder
    var body: some View {
        if searchText.isEmpty {
            bodyStandard
        } else {
            bodySearch
        }
    }

    @ViewBuilder
    var bodySearch: some View {
        if !filteredBySearchJourneys.isEmpty {
            Section("Journey's for \(searchText)") {
                ForEach(filteredBySearchJourneys) { journey in
                    journeyButton(for: journey)
                }
                .onDelete(perform: deleteSearch)
            }
        } else {
            ContentUnavailableView.search
        }
    }

    @ViewBuilder
    var bodyStandard: some View {
        if !journeys.isEmpty {
            Section("Journey's") {
                ForEach(journeys) { journey in
                    journeyButton(for: journey)
                }
                .onDelete(perform: delete)
            }
        }
    }
    
   
    
    
    private func delete(at offsets: IndexSet) {
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

    private func deleteSearch(at offsets: IndexSet) {
        for offset in offsets {
            let journey = filteredBySearchJourneys[offset]
            for step in journey.steps {
                modelContext.delete(step)
            }
            modelContext.delete(journey)
        }
        do {
            try modelContext.save()
        } catch {}
    }

    @ViewBuilder
    private func journeyButton(for journey: Journey) -> some View {
        Button {
            coordinator.push(page: .journeyDetails(journey))
        } label: {
            VStack(alignment: .leading) {
                Text("\(journey.journeyName)")
                    .font(isAssistiveAccessEnabled ? .title :.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(journey.dateCreated.formatted())
                    .font(isAssistiveAccessEnabled ?  .headline : .subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let description = journey.journeyDescription {
                    if isAssistiveAccessEnabled {
                        Divider()
                            .frame(height: 1)
                    }
                    Text(description)
                        .font(isAssistiveAccessEnabled ? .callout: .caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(isAssistiveAccessEnabled ? 4 : 2)
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

    private var filteredBySearchJourneys: [Journey] {
        journeys.filter { journey in
            journey.journeyName.contains(searchText)
        }
    }
}
