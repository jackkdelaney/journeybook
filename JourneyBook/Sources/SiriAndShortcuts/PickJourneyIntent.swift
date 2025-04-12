//
//  PickJourneyIntent.swift
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

import SwiftUI

struct OpenJourneyIntentSnippetView: View {
    @Environment(\.colorScheme) var colorScheme

    let journey: Journey
    var body: some View {
        HStack {
            VStack {
                Text(journey.journeyName)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let journeyDescription = journey.journeyDescription {
                    Text(journeyDescription)
                        .font(.caption)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            Spacer()

            VStack {
                Text("\(journey.steps.count)")
                    .font(.headline)
                    .fontWeight(.heavy)
                // .frame(maxWidth: .infinity, alignment: .trailing)
                Text("STEPS")
                    .font(.caption2)
                    .fontWeight(.heavy)
                // .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .overlay(
                Circle()
                    .stroke(.blue, lineWidth: 9)
                    .padding(6)
            )
        }
        .padding(.horizontal)
        .padding()
    }
}
