//
//  CurrentPhraseViewModelTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 15/04/2025.
//

import Testing

import SharedPersistenceKit

@testable import JourneyBook

struct CurrentPhraseViewModelTests {
    @MainActor @Test
    func testInitialisationSetsDefaultPropertiesCorrectly() {
        let phrase = Phrase.samplePhrase()
        let model = CurrentPhraseViewModel(phrase: phrase)

        #expect(model.text == phrase.text)
        #expect(model.colour == phrase.colour)
        #expect(model.fontSize == phrase.fontSize)
    }

    @MainActor @Test
    func testChangeColour() {
        let phrase = Phrase.samplePhrase()
        let model = CurrentPhraseViewModel(phrase: phrase)

        model.colour = .pink

        #expect(model.colour == .pink)
    }

    @MainActor @Test
    func testChangeFont() {
        let phrase = Phrase.samplePhrase()
        let model = CurrentPhraseViewModel(phrase: phrase)

        model.fontSize = .callout

        #expect(model.fontSize == .callout)
    }

    @MainActor @Test
    func testNoTextErrorThrow() {
        let phrase = Phrase.samplePhrase()
        let model = CurrentPhraseViewModel(phrase: phrase)

        model.text = ""

        #expect(throws: PhraseModelError.noText) {
            try model.save()
        }
    }

    @MainActor @Test
    func testAddPhraseNoText() {
        let phrase = Phrase.samplePhrase()
        let model = CurrentPhraseViewModel(phrase: phrase)

        model.text = ""

        #expect(throws: PhraseModelError.noText) {
            try model.save()
        }
    }
}
