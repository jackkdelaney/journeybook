//
//  LiveJourneyStepModel.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 11/04/2025.
//

import Foundation
import SharedPersistenceKit
import SwiftData

@Observable
class LiveJourneyStepModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var journey: Journey

    @MainActor
    init(journey: Journey) {
        modelContainer = try! ModelContainer(
            for: VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        modelContext = modelContainer.mainContext
        self.journey = journey
    }

    var journeyNotLive: Bool {
        liveJourneysByID.contains(journey.id)
    }

    private var liveJourneysByID: [UUID] {
        fetchResources()
            .compactMap { $0.journey }
            .map { $0.id }
        return []
    }

    private func start() {}

    func makeNewLiveJourney() {
        let liveJourney = LiveJourney(journey: journey)
        endJourneys()
        add(liveJourney)
    }

    private func endJourneys() {
        for liveJourney in fetchResources() {
            modelContext.delete(liveJourney)
        }
        do {
            try modelContext.save()

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension LiveJourneyStepModel {
    func fetchResources() -> [LiveJourney] {
        do {
            return try modelContext.fetch(FetchDescriptor<LiveJourney>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(_ liveJourney: LiveJourney) {
        modelContext.insert(liveJourney)
        do {
            try modelContext.save()

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
