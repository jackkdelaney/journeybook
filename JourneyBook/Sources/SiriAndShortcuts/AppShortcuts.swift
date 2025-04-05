//
//  AppShortcuts.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/04/2025.
//

import AppIntents
import SwiftData

class AppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
//        AppShortcut(
//            intent: NewWishIntent(),
//            phrases: [
//                "create new wish in \(.applicationName)",
//                "using \(.applicationName) create a new wish"
//            ],
//            shortTitle: "Create Wishlist Item",
//            systemImageName: "sparkles"
//        )
//        
        AppShortcut(
            intent: OpenJourneyIntent(),
            phrases: [
                "open \(\.$wish) using \(.applicationName)"
            ],
            shortTitle: "Open Wish",
            systemImageName: "sparkles.square.filled.on.square"
        )
        
//        AppShortcut(
//            intent: UpdateWishStatusIntent(),
//            phrases: [
//                "update status of \(\.$wish) using \(.applicationName)"
//            ],
//            shortTitle: "Update Status",
//            systemImageName: "wand.and.stars.inverse"
//        )

    }
}


enum ModelContextProvider { 
    static var context: ModelContext?
}

extension ModelContext {
    static func getContextForAppIntents() -> ModelContext {
        if let context = ModelContextProvider.context {
            return context
        }
        
        let schema = Schema([VisualResource.self, Phrase.self, Journey.self, JourneyStep.self, TransportRoute.self, Communication.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            return .init(container)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
