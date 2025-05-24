//
//  PhraseSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SharedPersistenceKit
import SwiftUI

enum PhraseSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case addNewPhrase
    case voices
    case editPhrase(Phrase)
}

extension PhraseSheet {
    @MainActor @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addNewPhrase: AddNewPhraseView()
        case .voices:
            PhraseVoiceSelectorView()
        case let .editPhrase(phrase):
            EditPhraseView(phrase: phrase)
        }
    }
}
