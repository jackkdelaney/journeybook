//
//  CurrentPhraseViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import Observation
import SwiftData
import SwiftUI

@Observable
class CurrentPhraseViewModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var text: String

    var fontSize: FontSizes {
        didSet {
            updateFontSize()
        }
    }

    var colour: Color {
        didSet {
            updateColor()
        }
    }

    var fontSizeAsInt: Int {
        didSet {
            fontSize = FontSizes(rawValue: fontSizeAsInt) ?? fontSize
            updateFontSize()
        }
    }

    var phrase: Phrase

    @MainActor
    init(phrase: Phrase) {
        self.phrase = phrase
        text = phrase.text
        colour = phrase.colour
        fontSize = phrase.fontSize
        fontSizeAsInt = phrase.fontSize.rawValue

        modelContainer = try! ModelContainer(
            for: VisualResource.self, Phrase.self, Journey.self,LiveJourney.self, JourneyStep.self, TransportRoute.self,Communication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        modelContext = modelContainer.mainContext
    }

    func save() throws {
        if text == "" {
            throw PhraseModelError.noText
        }
        phrase.text = text
        phrase.colour = colour
        do {
            try modelContext.save()

        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func updateColor() {
        if phrase.colour != colour {
            phrase.colour = colour
            do {
                try modelContext.save()

            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    private func updateFontSize() {
        if phrase.fontSize != fontSize {
            phrase.fontSize = fontSize

            do {
                try modelContext.save()

            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
