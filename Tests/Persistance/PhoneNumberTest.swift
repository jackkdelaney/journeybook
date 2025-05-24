//
//  PhoneNumberTest.swift
//  JourneyBook
//
//  Created by Jack Delaney on 16/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct PhoneNumberTests {
    @Test
    func initialisationSetsPropertiesCorrectly() {
        let number = PhoneNumber()

        #expect(number.countryCode == nil)
        #expect(number.phoneNumber == "")
    }

    @Test
    func formattedformattedPhoneNumberEmpty() {
        let number = PhoneNumber()

        #expect(number.formattedPhoneNumber == "+")
    }
}
