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

    @State private var cordinates: CLLocationCoordinate2D?

    @State private var resources = [VisualResource]()

    @State private var publicTransit: TransportRoute?

    @State private var communication : Communication?

    @State private var phrases = [Phrase]()
    


    var content: some View {
        JourneyStepInputForm(
            localName: $localName,
            localDescription: $localDescription,
            cordinates: $cordinates,
            resources: $resources,
            publicTransit: $publicTransit,
            communication: $communication,
            phrases: $phrases
        )
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
            communication: communication,
            visualResources: resources,
            route: publicTransit
        )

        for resource in resources {
            resource.steps.append(step)
        }

        for phrase in phrases {
            phrase.steps.append(step)
        }

        modelContext.insert(step)
        order()
        try? modelContext.save()
    }
}
