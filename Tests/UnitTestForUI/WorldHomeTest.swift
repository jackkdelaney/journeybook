//
//  WorldHomeTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 16/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook

struct WorldHomeTests {
    @Test
    func initialisationSetsPropertiesCorrectly() {
        let view = WorldHome()

        #expect(view.sheet == nil)
        #expect(view.searchText == "")
    }
}
