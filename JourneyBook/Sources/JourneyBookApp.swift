//
//  JourneyBookApp.swift
//  Project301
//
//  Created by Jack Delaney on 16/10/2024.
//

import SwiftData
import SwiftUI

@main
struct JourneyBookApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .modelContainer(for: [VisualResource.self, Phrase.self, Journey.self, JourneyStep.self, TransportRoute.self])
    }
}
