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
import Observation


@Observable
class LiveJourneyStepModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var activty: Activity<StepAttributes>? //TODO: Find exisiting one

    
    @MainActor
    init() {
        modelContainer = try! ModelContainer(
            for: VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        modelContext = modelContainer.mainContext
    }
    
    var liveJourneysByID: [UUID] {
        fetchResources()
            .compactMap { $0.journey }
            .map { $0.id }
    }
    
    
    func stop() {
        Task {
            for activity in Activity<StepAttributes>.activities {
                await activity.end(activity.content, dismissalPolicy: .immediate)
            }
            activty = nil
        }
    }
    
    
    func updateActivity() {
        let updatedContentState = StepAttributes.Status(stepNumber: 1, totalSteps: 2, description: "SUPER HOWDY", title: "Updated")

        if let activty {
            let staleDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())

            let updatedContent = ActivityContent(state: updatedContentState, staleDate: staleDate)
            Task {
                await activty.update(updatedContent)
            }
        }
    }
    
    var theLiveJourney: LiveJourney? {
        fetchResources()
            .first
    }
    
    
    func goBack() {
        
    }
    
    func goForward() {
        
    }
    

}

@Observable
class LiveJourneyStepModelWithinJourney : LiveJourneyStepModel {
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
