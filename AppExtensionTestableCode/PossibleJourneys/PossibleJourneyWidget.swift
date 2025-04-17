//
//  PossibleJourneyWidget.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 13/04/2025.
//

import AppIntents
import Foundation
import SharedPersistenceKit
import SwiftUI
import WidgetKit

// https://medium.com/@rishixcode/swiftdata-with-widgets-in-swiftui-0aab327a35d8

public struct PossibleJourneyWidget: Widget {
    public let kind: String = "JourneyCatalogs"
    public var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: JourneyProvider()
        ) { entry in
            JourneyWidgetView(entry: entry)
                .modelContainer(for: [VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self])
        }
        .configurationDisplayName("Journeys")
        .description("Journeys from JourneyBook.")
        .supportedFamilies([
            .systemSmall,
        ])
    }
    public init(){}
}
