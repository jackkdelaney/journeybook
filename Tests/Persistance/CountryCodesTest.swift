//
//  CountryCodesTest.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 16/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct CountryCodesTests {
    @Test
    func initialisationSetsPropertiesCorrectly() {
        let countries = CountryCodes.values()

        #expect(countries.isEmpty == false)
    }

    @Test
    func sortRules() {
        let countries = CountryCodes.values()

        #expect(countries.isEmpty == false)

        for i in 0 ..< countries.count - 1 {
            let currentCountry = countries[i]
            let nextCountry = countries[i + 1]
            #expect(currentCountry.countryName <= nextCountry.countryName)
        }
    }

    @Test
    func uKCode() {
        let countries = CountryCodes.values()

        if let uk = countries.first(where: { $0.countryCode == "GB" }) {
            #expect(uk.countryName == "United Kingdom")
            #expect(uk.dialCode == "44")

        } else {
            #expect(true == false, "No United Kingdom in Values Array")
        }
    }

    @Test
    func testDialCodeInt() {
        let countries = CountryCodes.values()

        if let uk = countries.first(where: { $0.countryCode == "US" }) {
            #expect(uk.countryName == "United States")
            #expect(uk.dialCode == "1")
            #expect(uk.dialCodeInt == 1)

        } else {
            #expect(true == false, "No United States in Values Array")
        }
    }
}
