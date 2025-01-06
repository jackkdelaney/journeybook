//
//  PhrasesSelectorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/01/2025.
//

import SwiftUI
import SwiftData
import AVFAudio

struct PhrasesSelectorView : View {
    @Binding var phrases : [Phrase]
    
    @Query var storedPhrases: [Phrase]
    
    let speaker = Speaker()

    @AppStorage("storedVoice") var storedVoice: String = ""
    
    @State var voice: AVSpeechSynthesisVoice? = nil


    var body : some View {
        List {
            ForEach(storedPhrases) { phrase in
                HStack {
                    Button {
                        try? speaker.speak(phrase.text, voice: voice)
                    } label: {
                        Label("Play this", systemImage: "play.square")
                            .foregroundStyle(.blue)
                            .labelStyle(.iconOnly)
                    }
                    Button {
                        if phrases.contains(phrase) {
                            phrases = phrases.filter { $0 != phrase }
                        } else {
                            phrases.append(phrase)
                        }
                        
                    } label: {
                        HStack {
                            Text(phrase.text)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            if phrases.contains(phrase) {
                                Label("Item Selected", systemImage: "checkmark")
                                    .labelStyle(.iconOnly)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear {
            if storedVoice != "" {
                voice = AVSpeechSynthesisVoice(identifier: storedVoice)
            }
        }
    }
}
