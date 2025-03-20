//
//  WorldHomeNavigationButtons.swift
//  JourneyBook
//
//  Created by Jack Delaney on 19/03/2025.
//

import SwiftUI

struct WorldHomeNavigationButtons: View {
    @EnvironmentObject private var coordinator: Coordinator

    @ViewBuilder
    var body: some View {
        Button {
            coordinator.push(page: .resourceManager)
        } label: {
            Label("Resource Manager", systemImage: "list.and.film")
        }
        Button {
            coordinator.push(page: .transportRoutes)
        } label: {
            Label(
                "Transport Routes",
                systemImage: "bus.doubledecker"
            )
        }
        Button {
            coordinator.push(page: .mapExperience)
        } label: {
            Label(
                "Live Bus Locations",
                systemImage: "map.circle.fill"
            )
        }
        Button {
            coordinator.push(page: .gliderPOC)
        } label: {
            Label(
                "Glider Proof of Concept",
                systemImage: "train.side.front.car"
            )
        }
        Button {
            coordinator.push(page: .communicationDirectory)
        } label: {
            Label("Communication Directory", systemImage: "figure.run.treadmill")
        }
        Button {
            coordinator.push(page: .phraseBook)
        } label: {
            Label("Phrase Book", systemImage: "book.pages")
        }
    }
}
