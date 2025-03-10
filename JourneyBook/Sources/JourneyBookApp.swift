//
//  JourneyBookApp.swift
//  Project301
//
//  Created by Jack Delaney on 16/10/2024.
//

// import PostHog
import SwiftData
import SwiftUI

@main
struct JourneyBookApp: App {
//    init() {
//        let POSTHOG_API_KEY = "phc_y0C7c21kV4Hn3qxLqNWdQev3Bhk66TnapSxK9fxVbAY"
//        // usually 'https://us.i.posthog.com' or 'https://eu.i.posthog.com'
//        let POSTHOG_HOST = "https://us.i.posthog.com"
//
//        let config = PostHogConfig(apiKey: POSTHOG_API_KEY, host: POSTHOG_HOST)
//        PostHogSDK.shared.setup(config)
//    }

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .modelContainer(for: [VisualResource.self, Phrase.self, Journey.self, JourneyStep.self, TransportRoute.self])
    }
}
