//
//  CommunicationViewModelErrorTest.swift
//  AppExtensionJBKit
//
//  Created by Jack Delaney on 18/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook
import SwiftUI

struct CommunicationViewModelErrorTests {
    @Test
    func initialisationSetsPropertiesCorrectly() {
        let modelA = CommunicationViewModelError.noTitleText
        let modelB = CommunicationViewModelError.noTitleText
        #expect(modelA.hashValue == modelB.hashValue)
    }

    @Test("Test Error Message Function",
          arguments: [CommunicationViewModelError.noTitleText, CommunicationViewModelError.noPhoneNumber, CommunicationViewModelError.noEmailOrMessage, CommunicationViewModelError.noPhoneOrmessage])
    func convertDegrees(error: CommunicationViewModelError) {
        let expectations: [CommunicationViewModelError: String] = [CommunicationViewModelError.noTitleText: "Please enter a title.", CommunicationViewModelError.noPhoneNumber: "Please enter a Phone Number", CommunicationViewModelError.noEmailOrMessage: "Please check you have entered a email and messsage.", CommunicationViewModelError.noPhoneOrmessage: "Please check you have entered a phone number and messsage."]
        #expect(error.errorMessage == expectations[error])
    }
}
