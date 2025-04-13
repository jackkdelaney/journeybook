//
//  PossibleJourneyWidget.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 13/04/2025.
//

import Foundation
import SwiftUI
import WidgetKit
import SharedPersistenceKit

//https://medium.com/@rishixcode/swiftdata-with-widgets-in-swiftui-0aab327a35d8

struct PossibleJourneyWidget: Widget {
    let kind: String = "PossibleJourneyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Text("Howdy!")
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(for: [VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self])
        }
    }
}

