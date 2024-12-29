//
//  PhraseVoiceSelectorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 28/12/2024.
//

import AVFAudio
import SwiftUI

struct PhraseVoiceSelectorView: SheetView {
    @Binding var voice: AVSpeechSynthesisVoice?

    @Environment(\.dismiss) var dismiss

    let speaker = Speaker()

    var sheetTitle: String {
        "Select Voice"
    }

    let otherVoices = AVSpeechSynthesisVoice.speechVoices().filter {
        $0.quality != .enhanced && $0.quality != .premium && $0.voiceTraits != .isPersonalVoice && $0.voiceTraits != .isNoveltyVoice && $0.language == AVSpeechSynthesisVoice.currentLanguageCode()
    }

    let premiumAndEnhancedVoices = AVSpeechSynthesisVoice.speechVoices().filter { $0.quality == .enhanced || $0.quality == .premium }
    let personalVoices = AVSpeechSynthesisVoice.speechVoices().filter { $0.voiceTraits == .isPersonalVoice }

    let novetlyVoice = AVSpeechSynthesisVoice.speechVoices().filter { $0.voiceTraits == .isNoveltyVoice }

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
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
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
                        try speaker.speak("Hello, I am \(currentVoice.name). Click the Chevron to select me.", voice: currentVoice)
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
}
