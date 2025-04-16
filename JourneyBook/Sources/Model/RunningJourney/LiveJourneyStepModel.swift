//
//  LiveJourneyStepModel.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 11/04/2025.
//

import ActivityKit
import CommonCodeKit
import Foundation
import Observation
import SharedPersistenceKit
import SwiftData

@Observable
class LiveJourneyStepModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var activty: Activity<StepAttributes>? {
        didSet {
            stepNumberFix()
        }
    }

    @MainActor
    init() {
        modelContainer = try! ModelContainer(
            for: VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        modelContext = modelContainer.mainContext
        stepNumber = 0
        stepNumberFix()
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

    private func stepNumberFix() {
        if let theLiveJourney {
            stepNumber = theLiveJourney.stepNumber
        } else {
            stepNumber = 0
        }
    }

    var theLiveJourney: LiveJourney? {
        return fetchResources()
            .first
    }

    private(set) var stepNumber: Int

    func goBack() {
        if !disableLastButton {
            if let theLiveJourneyUnwrapped = theLiveJourney {
                theLiveJourneyUnwrapped.stepNumber = theLiveJourneyUnwrapped.stepNumber - 1
                stepNumber = theLiveJourneyUnwrapped.stepNumber
            }
        }
        stepNumberFix()
    }

    func goForward() {
        if !disableNextButton {
            if let theLiveJourneyUnwrapped = theLiveJourney {
                theLiveJourneyUnwrapped.stepNumber = theLiveJourneyUnwrapped.stepNumber + 1
                stepNumber = theLiveJourneyUnwrapped.stepNumber
            }
        }
        stepNumberFix()
    }

    var disableLastButton: Bool {
        if stepNumber > 1 {
            return false
        }

        return true
    }

    var disableNextButton: Bool {
        if let theLiveJourney {
            if stepNumber < theLiveJourney.stepsAmount {
                return false
            }
        }
        return true
    }
}
