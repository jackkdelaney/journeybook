//
//  LiveJourneyStepModelWithinJourney.swift
//  JourneyBook
//
//  Created by Jack Delaney on 15/04/2025.
//

import ActivityKit
import CommonCodeKit
import Foundation
import Observation
import SharedPersistenceKit
import SwiftData

@Observable
class LiveJourneyStepModelWithinJourney: LiveJourneyStepModel {
    var journey: Journey

    @MainActor
    init(journey: Journey) {
        self.journey = journey
        super.init()
    }

    var journeyNotLive: Bool {
        !liveJourneysByID.contains(journey.id)
    }

    private func start() {}

    func makeNewLiveJourney() {
        let liveJourney = LiveJourney(journey: journey)
        endJourneys()
        add(liveJourney)
        startLiveActivity()
    }

    override var theLiveJourney: LiveJourney? {
        fetchResources()
            .first(where: { $0.journey?.id == journey.id })
    }

    func endJourneys() {
        for liveJourney in fetchResources() {
            modelContext.delete(liveJourney)
        }
        do {
            try modelContext.save()

        } catch {
            fatalError(error.localizedDescription)
        }
        stop()
    }

    private func startLiveActivity() {
        let attributes = StepAttributes()
        let contentState = StepAttributes.Status(stepNumber: theLiveJourney?.stepNumber ?? -1, totalSteps: theLiveJourney?.stepsAmount ?? -2, description: theLiveJourney?.journey?.journeyDescription, title: theLiveJourney?.journey?.journeyName ?? "Unkown")
        do {
            let staleDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())

            let content = ActivityContent(state: contentState, staleDate: staleDate, relevanceScore: 0.65)

            activty = try Activity<StepAttributes>.request(
                attributes: attributes,
                content: content
            )

            //                    let _ = try Activity<ActivityAttributesSample>.request(attributes: attributes, contentState: contentState)
        } catch {
            print(error.localizedDescription)
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
