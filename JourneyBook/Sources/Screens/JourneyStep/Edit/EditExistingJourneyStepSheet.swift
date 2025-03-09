//
//  EditExistingJourneyStepSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/03/2025.
//

import CoreLocation
import Foundation
import SwiftData
import SwiftUI

struct EditExistingJourneyStepSheet: SheetView {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Bindable var journeyStep: JourneyStep

    // MARK: Local Varibles

    @State private var localName: String
    @State private var localDescription: String

    @State private var cordinates: CLLocationCoordinate2D?

    @State private var resources: [VisualResource]

    @State private var publicTransit: TransportRoute?

    @State private var phrases: [Phrase]

    init(journeyStep: JourneyStep) {
        self.journeyStep = journeyStep
        localName = journeyStep.stepName
        localDescription = journeyStep.stepDescription ?? ""

        cordinates = journeyStep.location?.location ?? nil
        resources = journeyStep.visualResources.map { $0 }
        phrases = journeyStep.phrases.map { $0 }

//        print("BEFORE \(journeyStep.visualResources.count)")
////        for resource in journeyStep.visualResources {
////            print("ADDING A RESOURCE!!")
////            print(resources.count)
////            $resources.wrappedValue.append(resource)
////            print(resources.count)
////        }
////        print("AFTER")

        publicTransit = journeyStep.route

       
    }

    var sheetTitle: String {
        "Edit Step"
    }

    var content: some View {
        JourneyStepInputForm(
            localName: $localName,
            localDescription: $localDescription,
            cordinates: $cordinates,
            resources: $resources,
            publicTransit: $publicTransit,
            phrases: phrases
        )
    }

    var confirmButton: some View {
        Button("Update") {
            let desc = localDescription.isEmpty ? nil : localDescription
            let location: JourneyStepLocation?
            if let cordinates {
                location = JourneyStepLocation(location: CLLocationCoordinate2D(latitude: cordinates.latitude, longitude: cordinates.longitude))
            } else {
                location = nil
            }

            journeyStep.stepName = localName
            journeyStep.stepDescription = desc
            journeyStep.location = location
            journeyStep.route = publicTransit

            addNewPhrasesAndSteps()
            removeUnwantedResourcesAndPhrases()

            try? modelContext.save()
            dismiss()
        }
    }

    private func removeUnwantedResourcesAndPhrases() {
        for resource in journeyStep.visualResources {
            if resources.filter({ item in
                resource.id == item.id
            }).isEmpty {
                resource.steps.removeAll { $0.id == journeyStep.id }
                journeyStep.visualResources.removeAll {
                    $0.id == resource.id
                }
            }
        }

        for phrase in journeyStep.phrases {
            if phrases.filter({ item in
                phrase.id == item.id
            }).isEmpty {
                phrase.steps.removeAll { $0.id == journeyStep.id }
                journeyStep.phrases.removeAll {
                    $0.id == phrase.id
                }
            }
        }
    }

    private func addNewPhrasesAndSteps() {
        for resource in resources {
            if journeyStep.visualResources.filter({ item in
                item.id == resource.id
            }).isEmpty {
                resource.steps.append(journeyStep)
                journeyStep.visualResources.append(resource)
            }
        }

        for phrase in phrases {
            if journeyStep.phrases.filter({ item in
                item.id == phrase.id
            }).isEmpty {
                phrase.steps.append(journeyStep)
                journeyStep.phrases.append(phrase)
            }
        }
    }
}
