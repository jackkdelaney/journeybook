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
    lazy var synthesizer: AVSpeechSynthesizer = {
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        return synthesizer
    }()

    func speak(_ string: String, voice: AVSpeechSynthesisVoice?) {
        let utterance = AVSpeechUtterance(string: string)
        if let voice {
            utterance.voice = voice
        }
        synthesizer.speak(utterance)
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_: AVSpeechSynthesizer, willSpeakRangeOfSpeechString _: NSRange, utterance _: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(true)
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .interruptSpokenAudioAndMixWithOthers)
    }

    func speechSynthesizer(_: AVSpeechSynthesizer, didFinish _: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}
