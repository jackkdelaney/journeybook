//
//  AddNewJourneyStepView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import CoreLocation
import SwiftUI

struct AddNewJourneyStepView: SheetView {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Bindable var journey: Journey

    @State private var localName: String = ""
    @State private var localDescription: String = ""

    @State private var sheet: AddJourneyStepSheet?

    @State private var cordinates: CLLocationCoordinate2D?

    @State private var resources = [VisualResource]()

    @State private var publicTransit: TransportRoute?

    @State private var phrases = [Phrase]()

    var content: some View {
        Form {
            Section("Step Name") {
                TextField("Step Name", text: $localName)
            }
            Section("Description") {
                TextEditor(text: $localDescription)
            }
            locationSection
            resourceSection
            publicTransitSection
            phraseSection
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
    }

    var locationSection: some View {
        Section("Location") {
            if let cordinates {
                MapInDetailView(location: JourneyStepLocation(location: cordinates))
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .removeListRowPaddingInsets()
            } else {
                Button("Find Location") {
                    let locationWrapped = AddJourneyLocationStepGetter(location: $cordinates)
                    sheet = .getLocationFromAddress(locationWrapped)
                }
            }
        }
    }

    @ViewBuilder
    var resourceSection: some View {
        ForEach(resources) { visualResource in
            ResourceSection(resource: visualResource)
        }

        Section("Resource") {
            Button("Select Resource") {
                let resourceWrapped = AddJourneyLocationVisualResourceGetter(resources: $resources)
                sheet = .getVisualResourceFromList(resourceWrapped)
            }
        }
    }

    @ViewBuilder
    var publicTransitSection: some View {
        if let publicTransitResource = publicTransit {
            Section("Public Transit") {
                Text("\(publicTransitResource.url)")
                Button("Edit") {
                    let transportWrapped = AddJourneyTransportGetter(transport: $publicTransit)
                    sheet = .getTransportRouteFromList(transportWrapped)
                }
            }
        } else {
            Section("Public Transit") {
                Button("Add Public Transport Route") {
                    let transportWrapped = AddJourneyTransportGetter(transport: $publicTransit)
                    sheet = .getTransportRouteFromList(transportWrapped)
                }
            }
        }
    }

    @ViewBuilder
    var phraseSection: some View {
        Section(phraseText) {
            Button("Select Phrase's") {
                let phrasesWrapped = AddJourneyPhraseSelectionGetter(phrases: $phrases)
                sheet = .selectPhrases(phrasesWrapped)
            }
        }
    }

    var phraseText: String {
        return String(AttributedString(
            localized: "You have ^[\(phrases.count) \("Phrase")](inflect: true) in this step."
        ).characters)
    }

    var confirmButton: some View {
        Button("Save") {
            add()
            dismiss()
        }
        .disabled(localName.isEmpty)
    }

    var sheetTitle: String {
        "Add New Step"
    }

    private func order() {
        let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
        for (index, item) in sortedLocalList.enumerated() {
            item.orderIndex = index
        }
    }

    private func add() {
        let desc = localDescription.isEmpty ? nil : localDescription
        let location: JourneyStepLocation?
        if let cordinates {
            location = JourneyStepLocation(location: CLLocationCoordinate2D(latitude: cordinates.latitude, longitude: cordinates.longitude))
        } else {
            location = nil
        }

        let step = JourneyStep(
            stepName: localName,
            stepDescription: desc,
            journey: journey,
            location: location,
            visualResources: resources,
            route: publicTransit
        )

        for resource in resources {
            resource.steps.append(step)
        }

        for phrase in phrases {
            step.phrases.append(phrase)
        }
        modelContext.insert(step)
        order()
        try? modelContext.save()
    }
}
