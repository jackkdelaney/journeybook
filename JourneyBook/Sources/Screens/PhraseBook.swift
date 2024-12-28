//
//  PhraseBook.swift
//  JourneyBook
//
//  Created by Jack Delaney on 28/12/2024.
//

import Foundation
import AVFAudio

//https://bendodson.com/weblog/2024/04/03/using-your-personal-voice-in-an-ios-app/
class Speaker: NSObject {
    
    static let shared = Speaker()
    
    lazy var synthesizer: AVSpeechSynthesizer = {
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        return synthesizer
    }()
    
    func speak(_ string: String, voice : AVSpeechSynthesisVoice?) {
        let utterance = AVSpeechUtterance(string: string)
        if let voice {
            utterance.voice = voice
        }
        synthesizer.speak(utterance)
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(true)
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .interruptSpokenAudioAndMixWithOthers)
    }
        
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}

import SwiftUI

struct PhraseBook : View {
    let speaker = Speaker()
    
    let voices = AVSpeechSynthesisVoice.speechVoices()//.filter({$0.language == AVSpeechSynthesisVoice.currentLanguageCode()})
    
    @State var voice : AVSpeechSynthesisVoice? = nil

    
    var body : some View {
        VStack {
            Menu {
                ForEach(voices, id: \.self) { currentVoice in
                    Button(currentVoice.name) {
                       voice = currentVoice
                    }
                }
            
            } label: {
                Text("VOICES")
            }
            Button("REQUEST PERMISSION") {
                AVSpeechSynthesizer.requestPersonalVoiceAuthorization { status in
                    print(status.rawValue)
                }
            }
            Button("SPEAK!!") {
                print(voice?.name ?? "NO NAME")
                speaker.speak("Hello, world!",voice: voice)
            }
        }
            .navigationTitle("Phrase Book")
            .navigationBarTitleDisplayMode(.inline)
    }
}
