import Foundation
import Testing

@testable import JourneyBook

struct PhraseTest {
    @Test
    func testInitialisationWithJustPhraseText() {
        let phrase = Phrase(text: "Hello World", colour: .pink)
        #expect(phrase.text == "Hello World")
        #expect(phrase.id != UUID())
        #expect(phrase.dateCreated.timeIntervalSinceNow < 1)
        #expect(phrase.dateModified.timeIntervalSinceNow < 1)
    }

    @Test
    func testInitialisationWithJustPhraseTextAndID() {
        let id = UUID()
        let phrase = Phrase(text: "Hello World", colour: .pink, id: id)
        #expect(phrase.text == "Hello World")
        #expect(phrase.id == id)
        #expect(phrase.dateCreated.timeIntervalSinceNow < 1)
        #expect(phrase.dateModified.timeIntervalSinceNow < 1)
    }

    @Test
    func testInitialisationAllArguments() {
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
    func testTextMutationUpdatesDateModified() {
        var phrase = Phrase(text: "Initial Text", colour: .pink)
        let initialModifiedDate = phrase.dateModified
        phrase.text = "Updated Text"

        #expect(phrase.text == "Updated Text")

        #expect(phrase.dateModified > initialModifiedDate)
    }
}
