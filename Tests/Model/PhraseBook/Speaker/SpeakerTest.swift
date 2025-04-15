//
//  SpeakerTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 15/04/2025.
//

import Testing

@testable import JourneyBook

struct SpeakerTests {
    @MainActor @Test
    func testInitialisationSetsDefaultPropertiesCorrectly() {
        let model = Speaker()

        #expect(model.isSpeaking == false)
    }

    @MainActor @Test
    func testSpeakingEmptyStringThrows() {
        let model = Speaker()

        #expect(throws: SpeakerError.noText) {
            try model.speak("", voice: nil)
        }

        // otherVoiceCurrentlySpeaking
    }

    @MainActor @Test
    func testSpeakingWithTextDoesNotThrow() {
        let model = Speaker()

        #expect(throws: Never.self) {
            try model.speak("BOB", voice: nil)
        }
    }

    @MainActor @Test
    func checkIsSpeakingWorks() {
        let model = Speaker()

        var result: Bool?
        #expect(throws: SpeakerError.otherVoiceCurrentlySpeaking) {
            try model.speak("Hello", voice: nil)
            result = model.isSpeaking
            try model.speak("Howdy", voice: nil)
        }

        #expect(result == true)
    }

    @MainActor @Test
    func testSpeakingEmptyThrowsTwoSpeakingAtOnce() {
        let model = Speaker()

        #expect(throws: SpeakerError.otherVoiceCurrentlySpeaking) {
            try model.speak("Hello", voice: nil)
            try model.speak("Howdy", voice: nil)
        }
    }
}
