//
//  PhraseModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import Observation
import SharedPersistenceKit
import SwiftData
import SwiftUI

@Observable
class PhraseModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var text: String
    var colour: Color = .blue

    @MainActor
    init(text: String = "") {
        self.text = text
        modelContainer = try! ModelContainer(
            for: VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        modelContext = modelContainer.mainContext
    }

    func saveItem() throws {
        if text == "" {
            throw PhraseModelError.noText
        }

        let phrase = Phrase(text: text, colour: colour)
        add(phrase)
    }

    func clearItem() {
        text = ""
    }
}

extension PhraseModel {
    func fetchResources() -> [Phrase] {
        do {
            return try modelContext.fetch(FetchDescriptor<Phrase>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(_ phrase: Phrase) {
        modelContext.insert(phrase)
        do {
            try modelContext.save()

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

enum PhraseModelError: Error, Identifiable {
    var id: String {
        "\(hashValue)"
    }

    case noText
}

extension PhraseModelError {
    var errorMessage: String {
        switch self {
        case .noText:
            "Please enter text for this phrase."
        }
    }
}
