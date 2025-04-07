//
//  JourneyEntiy.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/04/2025.
//

import Foundation
import AppIntents
import SwiftData

struct JourneyEntiy: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Journey Item"
    
    static var defaultQuery = JourneyEntiyQuery()

    let id: UUID
    
    @Property(title: "Journey Item Title")
    var journeyName: String
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(journeyName)"
        )
    }
    
    init(swiftDataModel: Journey) {
        self.id = swiftDataModel.id
        self.journeyName = swiftDataModel.journeyName
    }
}

struct JourneyEntiyQuery: EntityQuery {
    func entities(for identifiers: [JourneyEntiy.ID]) async throws -> [JourneyEntiy] {
        let modelContext = ModelContext.getContextForAppIntents()
        let fetchDescriptor = FetchDescriptor<Journey>(
            predicate: #Predicate { identifiers.contains($0.id) }
        )
        
        return try modelContext
            .fetch(fetchDescriptor)
            .map(JourneyEntiy.init)
    }
    
    
    func suggestedEntities() async throws -> [JourneyEntiy] {
        let modelContext = ModelContext.getContextForAppIntents()
        let fetchDescriptor = FetchDescriptor<Journey>()
        
        return try modelContext
            .fetch(fetchDescriptor)
            .prefix(100) // Swift Shortcuts get slow with too many items
            .map(JourneyEntiy.init)
    }
}
