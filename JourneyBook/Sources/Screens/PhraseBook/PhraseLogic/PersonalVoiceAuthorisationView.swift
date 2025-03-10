//
//  PersonalVoiceAuthorisationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import AVFAudio
import SwiftUI

struct PersonalVoiceAuthorisationView: View {
    @State var status = AVSpeechSynthesizer.personalVoiceAuthorizationStatus

    @ViewBuilder
    var body: some View {
        Section("Personal Voice Status") {
            theView
        }
        .onAppear {
            self.status = AVSpeechSynthesizer.personalVoiceAuthorizationStatus
        }
        .onDisappear {
            self.status = AVSpeechSynthesizer.personalVoiceAuthorizationStatus
        }
    }

    @ViewBuilder var theView: some View {
        if status == .notDetermined {
            Button("Request Permission") {
                AVSpeechSynthesizer
                    .requestPersonalVoiceAuthorization { _ in
                        self.status =
                            AVSpeechSynthesizer.personalVoiceAuthorizationStatus
                    }
            }
        } else if status == .authorized {
            Text(
                "You have authorised Personal Voices. If your device has a personal voice, select it from the menu in the top right hand corner."
            )
        } else if status == .unsupported {
            Text("This device does not support Personal Voice. Please open this app on a device with a Personal Voice to try it out in this app. You can still choose a voice from the from the menu in the top right hand corner.")
        } else if status == .denied {
            Text(
                "Please open setting's to enable Personal Voice access for this app."
            )
        }
    }
}
