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
    func testInitialisationSetsPropertiesCorrectly() {
        let number = PhoneNumber()

        #expect(number.countryCode == nil)
        #expect(number.phoneNumber == "")
    }

    @Test
    func testFormattedformattedPhoneNumberEmpty() {
        let number = PhoneNumber()

        #expect(number.formattedPhoneNumber == "+")
    }
}
