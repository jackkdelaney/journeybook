//
//  JourneyTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 12/04/2025.
//

import Testing
import Foundation

@testable import SharedPersistenceKit

struct JourneyTests {

    //MARK: Tests for Initialisation
    @Test
    func testInitialisationWithJustNameAndDesc() {
        let journey = Journey(journeyName: "Test Journey", journeyDescription: "A test journey description")
        #expect(journey.journeyName == "Test Journey")
        #expect(journey.journeyDescription == "A test journey description")
        #expect(journey.id != UUID())
        #expect(journey.dateCreated.timeIntervalSinceNow < 1)
    }
    
    @Test
    func testInitialisationWithJustNameAndDescAndUUID() {
        let id = UUID()
        let journey = Journey(id : id, journeyName: "Test Journey", journeyDescription: "A test journey description")
        #expect(journey.journeyName == "Test Journey")
        #expect(journey.journeyDescription == "A test journey description")
        #expect(journey.id == id)
        #expect(journey.dateCreated.timeIntervalSinceNow < 1)
    }
    
    @Test
    func testInitialisationComplete() {
        let id = UUID()
        let date = Date.distantPast
        
        let journey = Journey(id : id, dateCreated: date, journeyName: "Test Journey", journeyDescription: "A test journey description")
        #expect(journey.journeyName == "Test Journey")
        #expect(journey.journeyDescription == "A test journey description")
        #expect(journey.id == id)
        #expect(journey.dateCreated == date)
    }
    
    @Test
    func testInitialisationWithJustName() {
        let journey = Journey(journeyName: "Test Journey")
        #expect(journey.journeyName == "Test Journey")
        #expect(journey.journeyDescription == nil)
        #expect(journey.id != UUID())
        #expect(journey.dateCreated.timeIntervalSinceNow < 1)
    }


    @Test
    func testJourneyNameMutation() {
        let journey = Journey(journeyName: "Initial Name")
        journey.journeyName = "Updated Name"
        #expect(journey.journeyName == "Updated Name")
    }
    
    @Test
    func testJourneyNameMutationWhenNotDeclaredAtStart() {
        let journey = Journey(journeyName: "Initial Name")
        journey.journeyDescription = "THIS IS A DESCRIPTION"
        #expect(journey.journeyDescription == "THIS IS A DESCRIPTION")
    }
    
    @Test
    func testJourneyNameMutationWhenDeclaredAtStart() {
        let journey = Journey(journeyName: "Initial Name",journeyDescription: "Howdy.....")
        journey.journeyDescription = "THIS IS A DESCRIPTION"
        #expect(journey.journeyDescription == "THIS IS A DESCRIPTION")
    }
    
    @Test
    func testJourneyNameMutationWhenDeclaredAtStartThenSetToNil() {
        let journey = Journey(journeyName: "Initial Name",journeyDescription: "Howdy.....")
        journey.journeyDescription = nil
        #expect(journey.journeyDescription == nil)
    }
}
