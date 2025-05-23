//
//  JourneyBookApp.swift
//  Project301
//
//  Created by Jack Delaney on 16/10/2024.
//

import SharedPersistenceKit

import SwiftData
import SwiftUI
import WidgetKit

@main
struct JourneyBookApp: App {
    init() {
        AppShortcuts.updateAppShortcutParameters()

        WidgetCenter.shared.reloadAllTimelines()

        // FOR UI TESTS ONLY
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            UIView.setAnimationsEnabled(false)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first
            {
                window.layer.speed = 100
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .modelContainer(for: [VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self])
    }
}
