//
//  WorldHome.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI

struct WorldHome: View {
    @EnvironmentObject private var coordinator: Coordinator

    @State private var sheet: JourneySheet? = nil

    var body: some View {
        List {
            AddNewJoruneyButtom(sheet: $sheet)
            JourneyItemsView(sheet: $sheet)
            AdvertButton(title: "Live Bus Locations", tagLine: "See bus locations live.", appPage: .mapExperience, symbol: "map.circle.fill")
            RSSContentView()
        }
        .navigationTitle("JourneyBook")
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    coordinator.push(page: .credits)
                } label: {
                    Label("Credits", systemImage: "info.circle")
                }
                Menu {
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
                        coordinator.push(page: .phraseBook)
                    } label: {
                        Label("Phrase Book", systemImage: "book.pages")
                    }
                } label: {
                    Label("Options", systemImage: "case")
                }
            }
        }
    }
}

