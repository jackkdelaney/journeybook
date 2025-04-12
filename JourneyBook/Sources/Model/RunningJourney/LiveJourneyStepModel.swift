//
//  LiveJourneyStepModel.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 11/04/2025.
//

import ActivityKit
import CommonCodeKit
import Foundation
import SharedPersistenceKit
import SwiftData

/*
 @State var activty : Activity<StepAttributes>?

 */
@Observable
class LiveJourneyStepModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var journey: Journey

    var activty: Activity<StepAttributes>?

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
        !liveJourneysByID.contains(journey.id)
    }

    var theLiveJourney: LiveJourney? {
        fetchResources()
            .first(where: { $0.journey?.id == journey.id })
    }

    private var liveJourneysByID: [UUID] {
        fetchResources()
            .compactMap { $0.journey }
            .map { $0.id }
    }

    private func start() {}

    func makeNewLiveJourney() {
        let liveJourney = LiveJourney(journey: journey)
        endJourneys()
        add(liveJourney)
        startLiveActivity()
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
        let contentState = StepAttributes.Status(stepNumber: theLiveJourney?.stepNumber ?? -1, totalSteps: theLiveJourney?.stepsAmount ?? -2, description: theLiveJourney?.journey?.journeyDescription)
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

    private func updateActivity() {
        let updatedContentState = StepAttributes.Status(stepNumber: 1, totalSteps: 2, description: "SUPER HOWDY")

        if let activty {
            let staleDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())

            let updatedContent = ActivityContent(state: updatedContentState, staleDate: staleDate)
            Task {
                await activty.update(updatedContent)
            }
        }
    }

    private func stop() {
        Task {
            for activity in Activity<StepAttributes>.activities {
                await activity.end(activity.content, dismissalPolicy: .immediate)
            }
            activty = nil
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
