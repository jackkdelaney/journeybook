//
//  CommunicationEditSheetTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 16/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook

struct CommunicationEditSheetTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let view = CommunicationEditSheet(communication: Communication.sampleCommunication())

        #expect(view.viewModel.communication.title == Communication.sampleCommunication().title)
        #expect(view.viewModel.communication.communictionType == Communication.sampleCommunication().communictionType)
        #expect(view.viewModel.communication.emailAddress == Communication.sampleCommunication().emailAddress)
        #expect(view.viewModel.communication.message == Communication.sampleCommunication().message)
        #expect(view.viewModel.communication.phoneNumber?.formattedPhoneNumber == Communication.sampleCommunication().phoneNumber?.formattedPhoneNumber)

        #expect(view.errorMessage == nil)
    }

    @Test
    func testConfirmButtonTitle() {
        let view = CommunicationEditSheet(communication: Communication.sampleCommunication())

        #expect(view.confirmButtonTitleText == "Update")
    }

    @Test
    func testSheetTitle() {
        let view = CommunicationEditSheet(communication: Communication.sampleCommunication())

        #expect(view.sheetTitle == "Edit Communication")
    }
}
