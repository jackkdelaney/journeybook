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

        resources = []
        for resource in journeyStep.visualResources {
            resources.append(resource)
        }

        publicTransit = journeyStep.route

        phrases = []
        for phrase in journeyStep.phrases {
            phrases.append(phrase)
        }
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
            
            //journeyStep
            
            
            let desc = localDescription.isEmpty ? nil : localDescription
            let location: JourneyStepLocation?
            if let cordinates {
                location = JourneyStepLocation(location: CLLocationCoordinate2D(latitude: cordinates.latitude, longitude: cordinates.longitude))
            } else {
                location = nil
            }
            
            for resource in journeyStep.visualResources {
              //  resource.steps.append(step)
            }

            for phrase in journeyStep.phrases {
              //  step.phrases.append(phrase)
            }
            
            

//            let step = JourneyStep(
//                stepName: localName,
//                stepDescription: desc,
//                journey: journey,
//                location: location,
//                visualResources: resources,
//                route: publicTransit
//            )

                // if objects.contains(where: { $0.name == "bob" }) {

            for resource in resources {
                if journeyStep.steps.filter { item in
                    item.id == resource.id
                }.isEmpty {
                    journeyStep.steps.append(resource)
                }
            }

            for phrase in phrases {
                journeyStep.phrases.append(phrase)
            }
            
            
            try? modelContext.save()
        }
    }
}
