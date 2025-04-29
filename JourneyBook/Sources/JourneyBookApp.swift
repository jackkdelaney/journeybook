//
//  JourneyBookApp.swift
//  Project301
//
//  Created by Jack Delaney on 16/10/2024.
//

import SharedPersistenceKit

import PostHog
import SwiftData
import SwiftUI
import WidgetKit
import TipKit

@main
struct JourneyBookApp: App {
    init() {
        AppShortcuts.updateAppShortcutParameters()

        Tips.showAllTipsForTesting()

        
        // TEMP
        try? Tips.configure()
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

        let POSTHOG_API_KEY = "phc_y0C7c21kV4Hn3qxLqNWdQev3Bhk66TnapSxK9fxVbAY"
        let POSTHOG_HOST = "https://us.i.posthog.com"

        let config = PostHogConfig(apiKey: POSTHOG_API_KEY, host: POSTHOG_HOST)
        

        
        
        PostHogSDK.shared.setup(config)
    }

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .modelContainer(for: [VisualResource.self, Phrase.self, Journey.self, LiveJourney.self, JourneyStep.self, TransportRoute.self, Communication.self])
    }
}
