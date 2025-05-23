//
//  JourneyViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import Observation
import SharedPersistenceKit
import SwiftData

@Observable
class JourneyViewModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var journeyName: String
    var journeyDescription: String?

    @MainActor
    init(journeyName: String = "", journeyDescription: String? = nil) {
        self.journeyName = journeyName
        self.journeyDescription = journeyDescription
        modelContainer = try! ModelContainer(for: VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        modelContext = modelContainer.mainContext
    }

    func saveItem() throws {
        if journeyName == "" {
            throw JourneyViewModelError.noJourneyText
        }

        let journey = Journey(journeyName: journeyName, journeyDescription: journeyDescription)
        add(journey)
    }

    func clearItem() {
        journeyName = ""
        journeyDescription = nil
    }
}

enum JourneyViewModelError: Error, Identifiable {
    var id: String {
        "\(hashValue)"
    }

    case noJourneyText
}

extension JourneyViewModelError {
    var errorMessage: String {
        switch self {
        case .noJourneyText:
            "Please enter a journey name."
        }
    }
}

extension JourneyViewModel {
    func fetchResources() -> [Journey] {
        do {
            return try modelContext.fetch(FetchDescriptor<Journey>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(_ journey: Journey) {
        modelContext.insert(journey)
        do {
            try modelContext.save()

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
