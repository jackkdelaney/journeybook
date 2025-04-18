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
    func testInitialisationSetsPropertiesCorrectlyPhone() {
        let type = CommunicationType.phone
        #expect(type.stringName == "Phone Number")
    }

    @Test
    func testInitialisationSetsPropertiesCorrectlyEmail() {
        let type = CommunicationType.email
        #expect(type.stringName == "Email")
    }

    @Test
    func testInitialisationSetsPropertiesCorrectlyMessage() {
        let type = CommunicationType.message
        #expect(type.stringName == "Message")
    }
}
