//
//  AppShortcuts.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/04/2025.
//

import AppIntents
import SwiftData

class AppShortcuts: AppShortcutsProvider {
    
    static var shortcutTileColor: ShortcutTileColor {
        return .purple
      }
    
   
    // Open a Journey
    // End my journey
    // Start my journey (also start my starred journey)
    //Next Step
    // Go Back a step
    
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenJourneyIntent(),
            phrases: [
                "open \(\.$journey) using \(.applicationName)",
                "open \(\.$journey) with \(.applicationName)",
                "start \(\.$journey) with \(.applicationName)",
                "start \(\.$journey) using \(.applicationName)"
            ],
            shortTitle: "Open Journey",
            systemImageName: "fossil.shell"
        )


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

        let schema = Schema([
            VisualResource.self, Phrase.self, Journey.self, JourneyStep.self,
            TransportRoute.self, Communication.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            let container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            return .init(container)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
