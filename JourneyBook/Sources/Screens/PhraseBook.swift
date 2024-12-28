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
    
    let otherVoices = AVSpeechSynthesisVoice.speechVoices().filter({
        $0.quality != .enhanced && $0.quality != .premium && $0.voiceTraits != .isPersonalVoice && $0.voiceTraits != .isNoveltyVoice && $0.language == AVSpeechSynthesisVoice.currentLanguageCode()
        
    })
    
    
    let premiumAndEnhancedVoices = AVSpeechSynthesisVoice.speechVoices().filter({$0.quality == .enhanced || $0.quality == .premium})
    let personalVoices = AVSpeechSynthesisVoice.speechVoices().filter({$0.voiceTraits == .isPersonalVoice})
    
    let novetlyVoice = AVSpeechSynthesisVoice.speechVoices().filter({$0.voiceTraits == .isNoveltyVoice})
    
    
    @State var voice : AVSpeechSynthesisVoice? = nil
    
    private func voiceOptions(voices : [AVSpeechSynthesisVoice]) -> some View {
        ForEach(voices, id: \.self) { currentVoice in
            HStack {
                Button {
                    speaker.speak("Hello, I am \(currentVoice.name). Click the Chevron to select me.",voice: currentVoice)
                } label: {
                    Label("Play Sample", systemImage: "play.circle")
                        .labelStyle(.iconOnly)
                        .padding(.vertical, 5)
                        .foregroundStyle(.blue)
                    Text(currentVoice.name)
                        .font(.headline)
                }
                Button {
                    print("SELECt")
                    voice = currentVoice
                } label: {
                    Label("Select Item", systemImage: "chevron.forward")
                        .foregroundStyle(.secondary)
                        .labelStyle(.iconOnly)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
              

                
            }
                
                
            }
        }
    
    
    var body : some View {
        VStack {
            List {
                if !personalVoices.isEmpty {
                    Section("Personal Voices") {
                        voiceOptions(voices: personalVoices)
                    }
                }
                if !premiumAndEnhancedVoices.isEmpty {
                    Section("Premium and Enhanced Voices") {
                        voiceOptions(voices: premiumAndEnhancedVoices)
                    }
                }
                if !novetlyVoice.isEmpty {
                    Section("Novelty Voices") {
                        voiceOptions(voices: novetlyVoice)

                    }
                }
                if !otherVoices.isEmpty {
                    Section("Other Voices") {
                        voiceOptions(voices: otherVoices)

                    }
                }
                
                
            }
            .buttonStyle(PlainButtonStyle())
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
