//
//  LiveJourneyTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 12/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct LiveJourneyTests {
    @Test
    func defaultInitialisation() {
        let liveJourney = LiveJourney()

        #expect(liveJourney.journey == nil)
        #expect(liveJourney.stepsAmount == 0)
        #expect(liveJourney.stepNumber == 0)
        #expect(liveJourney.currentStep == nil)
    }

    @Test
    func stepsAmountWithJourney() {
        let steps = [
            JourneyStep(stepName: "First Step", journey: Journey.sample()),
            JourneyStep(stepName: "First Step", journey: Journey.sample()),
            JourneyStep(stepName: "First Step", journey: Journey.sample()),
        ]
        let journey = Journey(journeyName: "Journey", steps: steps)

        let liveJourney = LiveJourney(journey: journey)

        #expect(liveJourney.stepsAmount == 3)
        journey.steps.removeLast()
        #expect(liveJourney.stepsAmount == 2)
        journey.steps.removeAll()
        #expect(liveJourney.stepsAmount == 0)
    }

    @Test
    func currentStepFunction() {
        let steps = [
            JourneyStep(stepName: "First Step", journey: Journey.sample()),
            JourneyStep(stepName: "Second Step", journey: Journey.sample()),
            JourneyStep(stepName: "Third Step", journey: Journey.sample()),
        ]
        let journey = Journey(journeyName: "Journey", steps: steps)

        let liveJourney = LiveJourney(journey: journey)

        liveJourney.stepNumber = 0
        #expect(liveJourney.currentStep?.stepName == "First Step")
        liveJourney.stepNumber = 1
        #expect(liveJourney.currentStep?.stepName == "Second Step")
    }

    @Test
    func currentStepFunctionStepNumberOutOfRange() {
        let steps = [
            JourneyStep(stepName: "First Step", journey: Journey.sample()),
            JourneyStep(stepName: "Second Step", journey: Journey.sample()),
            JourneyStep(stepName: "Third Step", journey: Journey.sample()),
        ]
        let journey = Journey(journeyName: "Journey", steps: steps)

        let liveJourney = LiveJourney(journey: journey)

        liveJourney.stepNumber = -1
        #expect(liveJourney.currentStep?.stepName == nil)
        liveJourney.stepNumber = 4
        #expect(liveJourney.currentStep?.stepName == nil)
    }
}
