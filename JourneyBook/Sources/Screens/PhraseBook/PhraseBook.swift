//
//  PhraseBook.swift
//  JourneyBook
//
//  Created by Jack Delaney on 28/12/2024.
//

import AVFAudio
import SwiftUI

struct PhraseBook: View {
    let speaker = Speaker()

    @State private var sheet: PhraseBookSheet? = nil

    @State var voice: AVSpeechSynthesisVoice? = nil

    @AppStorage("storedVoice") var storedVoice: String = ""

    var status = AVSpeechSynthesizer.personalVoiceAuthorizationStatus

    @State private var profileText = "Enter your bio"

    var body: some View {
        Form {
            Section {
                voiceStatus
            }
            if status == .notDetermined {
                Section {
                    Button("REQUEST PERMISSION") {
                        AVSpeechSynthesizer.requestPersonalVoiceAuthorization { status in
                        }
                    }
                }
            }
            Section("Text") {
                HStack {
                    Text("""
                    This
                    IS MULTI LINE

                    """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Button("Edit") {}
                }
            }
            Section("Text") {
                TextEditor(text: $profileText)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                    .navigationTitle("Phrase Book")
            }
            Section {
                Button("SPEAK!!") {
                    try? speaker.speak("Hello, world!", voice: voice)
                }
            }
        }
        .navigationTitle("Phrase Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    sheet = .voiceSelector

                } label: {
                    Label("Change Voice", systemImage: "music.microphone.circle")
                }
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView(voice: $voice)
        }
        .onAppear {
            if storedVoice != "" {
                voice = AVSpeechSynthesisVoice(identifier: storedVoice)
            }
        }
        .onChange(of: voice) {
            if let voice {
                if voice.identifier != storedVoice {
                    storedVoice = voice.identifier
                }
            }
        }
    }

    @ViewBuilder
    var voiceStatus: some View {
        if status == .authorized {
            Text("Authroized")
        }
        if status == .unsupported {
            Text("Unsupported")
        }
        if status == .denied || status == .notDetermined {
            Text("You have not provided acess to personal voice, todo so follow this guide.")
        }
    }
}
