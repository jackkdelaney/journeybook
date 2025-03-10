//
//  PhraseVoiceSelectorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import AVFAudio
import SwiftUI

struct PhraseVoiceSelectorView: SheetView {
    @State var voice: AVSpeechSynthesisVoice?

    init(voice: AVSpeechSynthesisVoice? = nil) {
        if voice == nil && storedVoice != "" {
            self.voice =
                AVSpeechSynthesisVoice(identifier: storedVoice)
        }
    }

    @Environment(\.dismiss) var dismiss
    @AppStorage("storedVoice") var storedVoice: String = ""

    let speaker = Speaker()

    var sheetTitle: String {
        "Select Voice"
    }

    let otherVoices = AVSpeechSynthesisVoice.speechVoices().filter {
        $0.quality != .enhanced && $0.quality != .premium
            && $0.voiceTraits != .isPersonalVoice
            && $0.voiceTraits != .isNoveltyVoice
            && $0.language == AVSpeechSynthesisVoice.currentLanguageCode()
    }

    let premiumAndEnhancedVoices = AVSpeechSynthesisVoice.speechVoices().filter
        { $0.quality == .enhanced || $0.quality == .premium }
    let personalVoices = AVSpeechSynthesisVoice.speechVoices().filter {
        $0.voiceTraits == .isPersonalVoice
    }

    let novetlyVoice = AVSpeechSynthesisVoice.speechVoices().filter {
        $0.voiceTraits == .isNoveltyVoice
    }

    var content: some View {
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
        .alert("Please wait until the other voice stops playing.", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }
        .onChange(of: voice) {
            if let voice {
                print("Inside")
                if voice.identifier != storedVoice {
                    print("Inside.")
                    storedVoice = voice.identifier
                }
            }
            print("OTHER")
        }
    }

    var confirmButton: some View {
        Button("Confirm") {
            dismiss()
        }
    }

    @State private var showingAlert = false

    private func voiceOptions(voices: [AVSpeechSynthesisVoice]) -> some View {
        ForEach(voices, id: \.self) { currentVoice in
            HStack {
                Button {
                    do {
                        try speaker.speak(
                            "Hello, I am \(currentVoice.name). Click the circle to Select Me.",
                            voice: currentVoice
                        )
                    } catch {
                        showingAlert = true
                    }
                } label: {
                    Label("Play Sample", systemImage: "play.circle")
                        .labelStyle(.iconOnly)
                        .padding(.vertical, 5)
                        .foregroundStyle(.blue)
                    Text(currentVoice.name)
                        .font(.headline)
                }
                Button {
                    voice = currentVoice
                } label: {
                    if storedVoice == currentVoice.identifier {
                        Label("Item Selected", systemImage: "checkmark.circle")
                            .foregroundStyle(.secondary)
                            .labelStyle(.iconOnly)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(maxHeight: .infinity)
                            .contentShape(Rectangle())
                    } else {
                        Label("Select Item", systemImage: "circle")
                            .foregroundStyle(.secondary)
                            .labelStyle(.iconOnly)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(maxHeight: .infinity)
                            .contentShape(Rectangle())
                    }
                }
            }
        }
    }
}
