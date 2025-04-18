//
//  PhraseModelTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 15/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook

struct PhraseModelTests {
    @MainActor @Test
    func testInitialisationSetsDefaultPropertiesCorrectly() {
        let model = PhraseModel(text: "example text")

        #expect(model.text == "example text")
        #expect(model.colour == .blue)
    }

    @MainActor @Test
    func testChangeColour() {
        let model = PhraseModel(text: "example text")
        model.colour = .pink

        #expect(model.colour == .pink)
    }

    @MainActor @Test
    func testClearItem() {
        let model = PhraseModel(text: "example text")
        model.clearItem()

        #expect(model.text == "")
    }

    @MainActor @Test
    func testNoTextErrorThrow() {
        let model = PhraseModel(text: "example text")
        model.text = ""

        #expect(throws: PhraseModelError.noText) {
            try model.saveItem()
        }
    }

    @MainActor @Test
    func testAddPhraseNoText() {
        let model = PhraseModel(text: "example text")
        model.text = ""

        let amountBefore = model.fetchResources().count

        #expect(throws: PhraseModelError.noText) {
            try model.saveItem()
        }
        #expect(model.fetchResources().count == amountBefore)
    }

    @MainActor @Test
    func testAddPhrase() {
        let model = PhraseModel(text: "example text")
        let amountBefore = model.fetchResources().count

        try! model.saveItem()

        #expect(model.fetchResources().count == (amountBefore + 1))
    }
}
