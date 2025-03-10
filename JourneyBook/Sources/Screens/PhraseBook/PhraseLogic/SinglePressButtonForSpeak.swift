//
//  SinglePressButtonForSpeak.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import AVFAudio
import SwiftUI

struct SinglePressButtonForSpeak<Content: View>: View {

    @AppStorage("storedVoice") var storedVoice: String = ""

    @State var voice: AVSpeechSynthesisVoice? = nil

    let speaker = Speaker()

    @Binding var text: String

    let content: Content
    let showImage: Bool

    init(
        text: Binding<String>, showImage: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self._text = text
        self.showImage = showImage
        self.content = content()
    }
    
    init(
        text: String, showImage: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        let binding = Binding<String>(
                    get: { text },
                    set: {_ in }
                )
        
        self._text = binding
        self.showImage = showImage
        self.content = content()
    }

    var body: some View {
        Button {
            print(text)
            try? speaker.speak(text, voice: voice)
        } label: {
            HStack {
                content
                    .frame(maxWidth: .infinity, alignment: .leading)
                if showImage {
                    Image(systemName: "play.circle")
                        .accessibilityHidden(true)
                }
            }
            .contentShape(Rectangle())
        }
        .onAppear {
            if storedVoice != "" {
                voice = AVSpeechSynthesisVoice(identifier: storedVoice)
            }

        }
    }
}
