//
//  Speaker.swift
//  JourneyBook
//
//  Created by Jack Delaney on 28/12/2024.
//

import AVFAudio
import Foundation

// https://bendodson.com/weblog/2024/04/03/using-your-personal-voice-in-an-ios-app/
class Speaker: NSObject {
    @Published var isSpeaking: Bool = false
    
    lazy var synthesizer: AVSpeechSynthesizer = {
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        return synthesizer
    }()

    func speak(_ string: String, voice: AVSpeechSynthesisVoice?) throws {
        if string.isEmpty {
            throw SpeakerError.noText
        }
        if isSpeaking == true {
            throw SpeakerError.otherVoiceCurrentlySpeaking
        } else {
            isSpeaking = true
        }
        let utterance = AVSpeechUtterance(string: string)
        if let voice {
            utterance.voice = voice
        }
        synthesizer.speak(utterance)
    }
}

enum SpeakerError: Error {
  case noText
  case otherVoiceCurrentlySpeaking
}

extension Speaker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_: AVSpeechSynthesizer, willSpeakRangeOfSpeechString _: NSRange, utterance _: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(true)
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .interruptSpokenAudioAndMixWithOthers)
    }

    func speechSynthesizer(_: AVSpeechSynthesizer, didFinish _: AVSpeechUtterance) {
        isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}
