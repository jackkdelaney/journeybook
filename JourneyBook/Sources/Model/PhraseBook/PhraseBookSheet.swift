//
//  PhraseBookSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 29/12/2024.
//

import SwiftUI
import AVFAudio

enum PhraseBookSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case voiceSelector
    case phrase(Phrase)
}

extension PhraseBookSheet {
    @ViewBuilder
    func buildView(voice: Binding<AVSpeechSynthesisVoice?>) -> some View {
        switch self {
        case .voiceSelector: PhraseVoiceSelectorView(voice: voice)
        case let .phrase(phrase):
            PhraseEditSheet(phrase: phrase)
        }
    }
}

