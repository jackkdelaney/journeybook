//
//  PickJourneyIntent.swift
//  JourneyBook
//
//  Created by Jack Delaney on 20/03/2025.
//

import AppIntents
import SwiftData

//https://superwall.com/blog/an-app-intents-field-guide-for-ios-developers




//struct JourneyEntity: AppEntity {
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Wishlist Item"
//
//    static var defaultQuery = JourneyEntityQuery()
//
//    let id: UUID
//
//    @Property(title: "Wishlist Item Title")
//    var title: String
//
//    var displayRepresentation: DisplayRepresentation {
//        DisplayRepresentation(
//            title: "\(title)"
//        )
//    }
//
//    init(swiftDataModel: Journey) {
//        self.id = swiftDataModel.id
//        self.title = swiftDataModel.journeyName
//    }
//}
//
//
//struct JourneyEntityQuery: EntityQuery {
//    func entities(for identifiers: [JourneyEntity.ID]) async throws -> [JourneyEntity] {
//        let modelContext = ModelContext.getContextForAppIntents()
//        let fetchDescriptor = FetchDescriptor<Journey>(
//            predicate: #Predicate { identifiers.contains($0.id) }
//        )
//        
//        return try modelContext
//            .fetch(fetchDescriptor)
//            .map(JourneyEntity.init)
//    }
//    
//    
//    func suggestedEntities() async throws -> [JourneyEntity] {
//        let modelContext = ModelContext.getContextForAppIntents()
//        let fetchDescriptor = FetchDescriptor<Journey>()
//        
//        return try modelContext
//            .fetch(fetchDescriptor)
//            .map(JourneyEntity.init)
//    }
//}
//
//
//enum ModelContextProvider {
//    static var context: ModelContext?
//}
//
//
//extension ModelContext {
//    static func getContextForAppIntents() -> ModelContext {
//        if let context = ModelContextProvider.context {
//            return context
//        }
//        
//        let schema = Schema([
//            VisualResource.self, Phrase.self, Journey.self,
//            JourneyStep.self, TransportRoute.self, Communication.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
//            return .init(container)
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }
//}
