//
//  PhraseTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 12/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct PhraseTests {
    @Test
    func initialisationWithJustPhraseText() {
        let phrase = Phrase(text: "Hello World", colour: .pink)
        #expect(phrase.text == "Hello World")
        #expect(phrase.id != UUID())
        #expect(phrase.dateCreated.timeIntervalSinceNow < 1)
        #expect(phrase.dateModified.timeIntervalSinceNow < 1)
    }

    @Test
    func initialisationWithJustPhraseTextAndID() {
        let id = UUID()
        let phrase = Phrase(text: "Hello World", colour: .pink, id: id)
        #expect(phrase.text == "Hello World")
        #expect(phrase.id == id)
        #expect(phrase.dateCreated.timeIntervalSinceNow < 1)
        #expect(phrase.dateModified.timeIntervalSinceNow < 1)
    }

    @Test
    func initialisationAllArguments() {
        let id = UUID()
        let dateCreated = Date.distantPast
        let dateModified = Date.distantFuture
        let phrase = Phrase(text: "Hello World", colour: .pink, id: id, dateCreated: dateCreated, dateModified: dateModified)
        #expect(phrase.text == "Hello World")
        #expect(phrase.id == id)
        #expect(phrase.dateCreated == dateCreated)
        #expect(phrase.dateModified == dateModified)
    }

    @Test
    func textMutationUpdatesDateModified() {
        let phrase = Phrase(text: "Initial Text", colour: .pink)
        let initialModifiedDate = phrase.dateModified
        phrase.text = "Updated Text"

        #expect(phrase.text == "Updated Text")

        #expect(phrase.dateModified > initialModifiedDate)
    }
}
