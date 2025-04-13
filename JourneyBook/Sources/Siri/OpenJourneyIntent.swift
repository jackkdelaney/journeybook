//
//  OpenJourneyIntent.swift
//  JourneyBook
//
//  Created by Jack Delaney on 20/03/2025.
//

import AppIntents
import Foundation
import SharedPersistenceKit
import SwiftData

// https://superwall.com/blog/an-app-intents-field-guide-for-ios-developers

struct OpenJourneyIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Journey"
    static var openAppWhenRun = true

    @Parameter(title: "Journey")
    var journey: JourneyEntiy

    static var parameterSummary: some ParameterSummary {
        Summary("Open \(\.$journey)")
    }

    func perform() async throws -> some IntentResult & ProvidesDialog {
        let modelContext = ModelContext.getContextForAppIntents()
        guard let navigationCoordinator = Coordinator.activeCoordinator else {
            throw IntentError.coordinatorNotFound
        }

        let fetchDescriptor = FetchDescriptor<Journey>()
        let items = try? modelContext.fetch(fetchDescriptor)
        guard let swiftDataItem = (items?.first { $0.id == journey.id }) else {
            throw IntentError.itemNotFound
        }

        print("Opening \(swiftDataItem.journeyName)")

        await MainActor.run {
            navigationCoordinator.popToRoot()
            navigationCoordinator.push(page: .journeyDetails(swiftDataItem))
        }

        return .result(
            dialog: "Opening \(swiftDataItem.journeyName)")
    }
}

enum IntentError: Error {
    case itemNotFound
    case coordinatorNotFound
}
