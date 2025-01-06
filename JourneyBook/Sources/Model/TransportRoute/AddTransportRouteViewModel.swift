//
//  AddTransportRouteViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/01/2025.
//

import Foundation
import Observation
import SwiftData

@Observable
class AddTransportRouteViewModel {
    func saveItem() {
        if let routeName, let url {
            let route = TransportRoute(routeName: routeName, url: url)
            add(route)
        }
    }

    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var routeName: String?
    var url: URL?

    var saveable: Bool {
        routeName != nil && url != nil
    }

    @MainActor
    init(routeName: String? = nil, url: URL? = nil) {
        self.routeName = routeName
        self.url = url

        modelContainer = try! ModelContainer(for: VisualResource.self, Phrase.self, Journey.self, JourneyStep.self, TransportRoute.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        modelContext = modelContainer.mainContext
    }

    func clearItem() {
        routeName = nil
        url = nil
    }
}

extension AddTransportRouteViewModel {
    func fetchResources() -> [TransportRoute] {
        do {
            return try modelContext.fetch(FetchDescriptor<TransportRoute>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(_ resource: TransportRoute) {
        modelContext.insert(resource)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
