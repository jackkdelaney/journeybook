//
//  LiveJourneyStepModelTest.swift
//  JourneyBook
//
//  Created by Jack Delaney on 15/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook

struct LiveJourneyStepModelTests {
    init() async {
        let model = await LiveJourneyStepModelWithinJourney(journey: Journey.sampleNewYork())
        model.endJourneys()
    }
    
    
    @MainActor @Test
    func testInitialisationSetsDefaultPropertiesCorrectly() {
        let model = LiveJourneyStepModel()
        
        #expect(model.activty == nil)
        #expect(model.theLiveJourney == nil)
        #expect(model.stepNumber == 0)
        #expect(model.disableNextButton == true)
        #expect(model.disableLastButton == true)
        
        
    }
}
