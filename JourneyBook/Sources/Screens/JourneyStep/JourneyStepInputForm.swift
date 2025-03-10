//
//  JourneyStepInputForm.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/03/2025.
//

import CoreLocation
import SwiftUI

struct JourneyStepInputForm: View {
    @State private var sheet: AddJourneyStepSheet?

    @Binding var localName: String
    @Binding var localDescription: String

    @Binding var cordinates: CLLocationCoordinate2D?

    @Binding var resources: [VisualResource]

    @Binding var publicTransit: TransportRoute?

    @Binding var phrases: [Phrase]

    var body: some View {
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

    @ViewBuilder
    private var resourceSection: some View {
        ForEach(resources) { visualResource in
            ResourceSection(resource: visualResource)
        }

        Section("Resource") {
            Button("Select Resource") {
                let resourceWrapped = AddJourneyLocationVisualResourceGetter(
                    resources: $resources)
                sheet = .getVisualResourceFromList(resourceWrapped)
            }
        }
    }

    @ViewBuilder
    private var publicTransitSection: some View {
        if let publicTransitResource = publicTransit {
            Section("Public Transit") {
                Text("\(publicTransitResource.url)")
                Button("Edit") {
                    let transportWrapped = AddJourneyTransportGetter(
                        transport: $publicTransit)
                    sheet = .getTransportRouteFromList(transportWrapped)
                }
            }
        } else {
            Section("Public Transit") {
                Button("Add Public Transport Route") {
                    let transportWrapped = AddJourneyTransportGetter(
                        transport: $publicTransit)
                    sheet = .getTransportRouteFromList(transportWrapped)
                }
            }
        }
    }

    @ViewBuilder
    private var phraseSection: some View {
        Section(phraseText) {
            Button("Select Phrase's") {
                let phrasesWrapped = AddJourneyPhraseSelectionGetter(
                    phrases: $phrases)
                sheet = .selectPhrases(phrasesWrapped)
            }

        }
        if !phrases.isEmpty {
            Section {
                chosenPhrases
            }
        }

    }

    @ViewBuilder
    private var chosenPhrases: some View {
        ForEach(phrases) { phrase in
            SinglePressButtonForSpeak(text: phrase.text) {
                Text(phrase.text)
            }
        }
        .onDelete(perform: deletePhrase)

    }

    private func deletePhrase(at offsets: IndexSet) {
        phrases.remove(atOffsets: offsets)

    }

    private var locationSection: some View {
        Section("Location") {
            if let cordinatesWrapped = cordinates {
                MapInDetailView(
                    location: JourneyStepLocation(location: cordinatesWrapped)
                )
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .removeListRowPaddingInsets()
                Button("Clear Location") {
                    cordinates = nil
                }
            } else {
                Button("Find Location") {
                    let locationWrapped = AddJourneyLocationStepGetter(
                        location: $cordinates)
                    sheet = .getLocationFromAddress(locationWrapped)
                }
            }
        }
    }

    var phraseText: String {
        return String(
            AttributedString(
                localized:
                    "You have ^[\(phrases.count) \("Phrase")](inflect: true) in this step."
            ).characters)
    }
}
