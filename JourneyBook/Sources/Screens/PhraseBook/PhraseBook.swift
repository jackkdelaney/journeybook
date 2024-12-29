//
//  PhraseBook.swift
//  JourneyBook
//
//  Created by Jack Delaney on 28/12/2024.
//

import AVFAudio
import SwiftData
import SwiftUI

struct PhraseBook: View {
    @Query var phrases: [Phrase]
    @Environment(\.modelContext) var modelContext

    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let phrase = phrases[offset]
            modelContext.delete(phrase)
        }
        do {
            try modelContext.save()
        } catch {}
    }

    let speaker = Speaker()

    @State private var sheet: PhraseBookSheet? = nil

    @State var voice: AVSpeechSynthesisVoice? = nil

    @AppStorage("storedVoice") var storedVoice: String = ""

    var status = AVSpeechSynthesizer.personalVoiceAuthorizationStatus

    @State private var profileText = "Enter your bio"

    var phrasesList: some View {
        List {
            Section("DEBUG") {
                voiceStatus
            }
            if status == .notDetermined {
                Section("Request For Permission") {
                    Section {
                        Button("REQUEST PERMISSION") {
                            AVSpeechSynthesizer.requestPersonalVoiceAuthorization { _ in
                            }
                        }
                    }
                    
                }
            }
            Section {
                ForEach(phrases) { phrase in
                    HStack {
                        Text(phrase.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button("Edit") {}
                        Button("Play") {
                            try? speaker.speak(phrase.text, voice: voice)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .onDelete(perform: delete)
                
                Button("Add New Phrase"){
                    let phrase = Phrase(text: "Hello")
                    modelContext.insert(phrase)
                    try? modelContext.save()
                    sheet = .phrase(phrase)
                }

//            Section("Text") {
//                TextEditor(text: $profileText)
//                    .foregroundStyle(.secondary)
//                    .padding(.horizontal)
//                    .navigationTitle("Phrase Book")
//            }

            } header: {
                Text("Phrases")
            } footer: {
                Text("Your're Phrases for this app are listed above")
            }
        }
    }

    var body: some View {
        phrasesList
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
