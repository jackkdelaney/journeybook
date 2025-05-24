//
//  AddressResultTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 12/04/2025.
//

import Foundation
import Testing

@testable import JourneyBook

struct AddressResultTests {
    @Test
    func initialisationSetsPropertiesCorrectly() {
        let result = AddressResult(title: "CSB", subtitle: "16 Malone Rd, Belfast BT9 5BN")

        #expect(result.title == "CSB")
        #expect(result.subtitle == "16 Malone Rd, Belfast BT9 5BN")
    }

    @Test
    func ensuringUUIDWorksCorrectly() {
        let result1 = AddressResult(title: "CSB", subtitle: "16 Malone Rd, Belfast BT9 5BN")
        let result2 = AddressResult(title: "CSB", subtitle: "16 Malone Rd, Belfast BT9 5BN")

        #expect(result1.id != result2.id)
        #expect(result1.id == result1.id)
        #expect(result2.id == result2.id)
    }
}
