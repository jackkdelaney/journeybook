//
//  LiveJourneyStepModelWithinJourneyTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 15/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook

struct LiveJourneyStepModelWithinJourneyTests {
    init() async {
        let model = await LiveJourneyStepModelWithinJourney(journey: Journey.sampleNewYork())
        model.endJourneys()
    }

    @MainActor @Test
    func testInitialisationSetsDefaultPropertiesCorrectly() {
        let model = LiveJourneyStepModelWithinJourney(journey: Journey.sampleNewYork())

        #expect(model.journey.id == Journey.sampleNewYork().id)
        #expect(model.journeyNotLive == true)
    }

    @MainActor @Test
    func isJourneyInList() {
        let model = LiveJourneyStepModelWithinJourney(journey: Journey.sampleNewYork())

        #expect(model.journeyNotLive == true)
        #expect(model.theLiveJourney == nil)

        let liveJourney = LiveJourney(journey: Journey.sampleNewYork())
        model.add(liveJourney)

        #expect(model.journeyNotLive == false)
        #expect(model.theLiveJourney == liveJourney)
    }

    @MainActor @Test
    func testStartJourney() {
        let model = LiveJourneyStepModelWithinJourney(journey: Journey.sampleNewYork())

        model.makeNewLiveJourney()

        #expect(model.journeyNotLive == false)
        #expect(model.theLiveJourney?.journey?.id == Journey.sampleNewYork().id)
    }
}
