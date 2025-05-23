//
//  CommunicationEditableViewModelTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 16/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook

struct CommunicationEditableViewModelTests {
    @MainActor @Test
    func initialisationSetsPropertiesCorrectly() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())

        #expect(model.communication.title == Communication.sampleCommunication().title)
        #expect(model.communication.communictionType == Communication.sampleCommunication().communictionType)
        #expect(model.communication.emailAddress == Communication.sampleCommunication().emailAddress)
        #expect(model.communication.message == Communication.sampleCommunication().message)
        #expect(model.communication.phoneNumber?.formattedPhoneNumber == Communication.sampleCommunication().phoneNumber?.formattedPhoneNumber)
    }

    @MainActor @Test
    func testClearItem() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())

        model.clearItem()

        #expect(model.title == "")
        #expect(model.phoneNumber == nil)
        #expect(model.emailAddress == nil)
        #expect(model.message == nil)
    }

    @MainActor @Test
    func testEmailAddresssBinding() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())

        model.emailAddresssBinding.wrappedValue = ""

        #expect(model.emailAddress == nil)
        #expect(model.emailAddresssBinding.wrappedValue == "")

        model.emailAddresssBinding.wrappedValue = "test@test.com"

        #expect(model.emailAddress == "test@test.com")
        #expect(model.emailAddresssBinding.wrappedValue == "test@test.com")
    }

    @MainActor @Test
    func testPhoneNumberBinding() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())
        model.phoneNumber = PhoneNumber(phoneNumber: "+1234567890")

        model.phoneNumberBinding.wrappedValue = nil

        #expect(model.phoneNumberBinding.wrappedValue == nil)
    }

    @MainActor @Test
    func testPhoneNumberStringBinding() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())
        model.phoneNumber = PhoneNumber(phoneNumber: "+1234567890")
        #expect(model.phoneNumberStringBinding.wrappedValue == model.phoneNumber?.phoneNumber)

        model.phoneNumberStringBinding.wrappedValue = ""

        #expect(model.phoneNumber?.phoneNumber == "")
        #expect(model.phoneNumberStringBinding.wrappedValue == "")
    }

    @MainActor @Test
    func messageBinding() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())
        model.message = "bob"
        #expect(model.messsageBinding.wrappedValue == "bob")

        model.messsageBinding.wrappedValue = ""

        #expect(model.message == nil)
        #expect(model.messsageBinding.wrappedValue == "")

        model.messsageBinding.wrappedValue = "A"

        #expect(model.message == "A")
        #expect(model.messsageBinding.wrappedValue == "A")
    }

    @MainActor @Test
    func testSaveItem() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())

        model.title = ""

        #expect(throws: CommunicationViewModelError.noTitleText) {
            try model.saveItem()
        }
    }

    @MainActor @Test
    func isValidViatestSaveItemForPhone() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())

        model.communictionType = .phone
        model.phoneNumber = PhoneNumber(countryCode: CountryWithCode.example, phoneNumber: "1234567890")

        #expect(throws: Never.self) {
            try model.saveItem()
        }

        model.phoneNumber = PhoneNumber(countryCode: nil, phoneNumber: "1234567890")

        #expect(throws: CommunicationViewModelError.noPhoneNumber) {
            try model.saveItem()
        }
    }

    @MainActor @Test
    func isValidViatestSaveItemForEmail() {
        let model = CommunicationEditableViewModel(communication: Communication.sampleCommunication())

        model.communictionType = .email
        model.message = "HOWDY"
        model.emailAddress = "HOWDY@example.net"

        #expect(throws: Never.self) {
            try model.saveItem()
        }

        model.emailAddress = nil

        #expect(throws: CommunicationViewModelError.noEmailOrMessage) {
            try model.saveItem()
        }

        model.emailAddress = "HOWDY@example.net"
        model.message = nil

        #expect(throws: CommunicationViewModelError.noEmailOrMessage) {
            try model.saveItem()
        }
    }
}
