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
    func initialisationSetsPropertiesCorrectly() {
        let country = CountryWithCode.example

        #expect(country.countryCode == "GB")
        #expect(country.countryName == "United Kingdom")
        #expect(country.dialCode == "44")
    }

    @Test
    func dialCodeIntFunction() {
        let country = CountryWithCode.example

        #expect(country.dialCode == "44")
        #expect(country.dialCodeInt == 44)
    }

    @Test
    func idComputedVar() {
        let country = CountryWithCode.example

        #expect(country.id == "GB-United Kingdom-44")
    }

    @Test
    func notEqutableTwoCountrysWithSameDialCode() {
        let countryA = CountryWithCode.example
        let countryB = CountryWithCode(countryCode: "IM", countryName: "Isle of Man", dialCode: "44")

        #expect(countryA != countryB)
    }

    @Test
    func equtableTwoidenticalCountrys() {
        let countryA = CountryWithCode.example
        let countryB = CountryWithCode.example

        #expect(countryA == countryB)
    }

    @Test
    func notEqutableTwoCountrys() {
        let countryA = CountryWithCode.example
        let countryB = CountryWithCode(countryCode: "IM", countryName: "Isle of Man", dialCode: "440")

        #expect(countryA != countryB)
    }
}
