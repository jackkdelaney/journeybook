//
//  PickJourneyIntent.swift
//  JourneyBook
//
//  Created by Jack Delaney on 20/03/2025.
//


import Foundation
import AppIntents
import SwiftData

//https://superwall.com/blog/an-app-intents-field-guide-for-ios-developers



struct OpenJourneyIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Journey"
    static var openAppWhenRun = true
    
    @Parameter(title: "Journey")
    var wish: JourneyEntiy
    
    static var parameterSummary: some ParameterSummary {
        Summary("Open \(\.$wish)")
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let modelContext = ModelContext.getContextForAppIntents()
        guard let navigationCoordinator = AppNavigationCoordinator.activeCoordinator else {
            throw IntentError.coordinatorNotFound
        }
        
        let fetchDescriptor = FetchDescriptor<WishlistItem>()
        let items = try? modelContext.fetch(fetchDescriptor)
        guard let swiftDataItem = (items?.first { $0.id == wish.id }) else {
            throw IntentError.itemNotFound
        }
        
        navigationCoordinator.clear()
        navigationCoordinator.navigate(to: swiftDataItem)
        
        return .result(dialog: "Opening...")
    }
}

