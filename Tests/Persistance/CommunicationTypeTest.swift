//
//  CommunicationTypeTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 17/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct CommunicationTypeTests {
    @Test
    func initialisationSetsPropertiesCorrectlyPhone() {
        let type = CommunicationType.phone
        #expect(type.stringName == "Phone Number")
    }

    @Test
    func initialisationSetsPropertiesCorrectlyEmail() {
        let type = CommunicationType.email
        #expect(type.stringName == "Email")
    }

    @Test
    func initialisationSetsPropertiesCorrectlyMessage() {
        let type = CommunicationType.message
        #expect(type.stringName == "Message")
    }
}
