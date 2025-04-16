//
//  CountryWithCodeTest.swift
//  SharedPersistenceKit
//
//  Created by Jack Delaney on 16/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct CountryWithCodeTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let country = CountryWithCode.example

        #expect(country.countryCode == "GB")
        #expect(country.countryName == "United Kingdom")
        #expect(country.dialCode == "44")
    }

    @Test
    func testDialCodeIntFunction() {
        let country = CountryWithCode.example

        #expect(country.dialCode == "44")
        #expect(country.dialCodeInt == 44)
    }

    @Test
    func testIdComputedVar() {
        let country = CountryWithCode.example

        #expect(country.id == "GB-United Kingdom-44")
    }

    @Test
    func testNotEqutableTwoCountrysWithSameDialCode() {
        let countryA = CountryWithCode.example
        let countryB = CountryWithCode(countryCode: "IM", countryName: "Isle of Man", dialCode: "44")

        #expect(countryA != countryB)
    }

    @Test
    func testEqutableTwoidenticalCountrys() {
        let countryA = CountryWithCode.example
        let countryB = CountryWithCode.example

        #expect(countryA == countryB)
    }

    @Test
    func testNotEqutableTwoCountrys() {
        let countryA = CountryWithCode.example
        let countryB = CountryWithCode(countryCode: "IM", countryName: "Isle of Man", dialCode: "440")

        #expect(countryA != countryB)
    }
}
