//
//  CommunicationDetailViewTest.swift
//  JourneyBookTestsUI
//
//  Created by Jack Delaney on 16/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook

struct CommunicationDetailViewTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let view = CommunicationDetailView(communication: Communication.sampleCommunication(), inSheet: true)

        #expect(view.communication.title == Communication.sampleCommunication().title)
        #expect(view.communication.communictionType == Communication.sampleCommunication().communictionType)
        #expect(view.communication.emailAddress == Communication.sampleCommunication().emailAddress)
        #expect(view.communication.message == Communication.sampleCommunication().message)
        #expect(view.communication.phoneNumber?.formattedPhoneNumber == Communication.sampleCommunication().phoneNumber?.formattedPhoneNumber)

        #expect(view.sheet == nil)
    }
   
}
