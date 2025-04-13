//
//  Journey.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import Foundation
import SwiftData

@Model
public class Journey {
    public private(set) var id: UUID
    public private(set) var dateCreated: Date
    public var journeyName: String
    public var journeyDescription: String?

    @Relationship(deleteRule: .nullify, inverse: \JourneyStep.journey) public var steps: [JourneyStep]

    public init(id: UUID = UUID(), dateCreated: Date = Date.now, journeyName: String, journeyDescription: String? = nil, steps: [JourneyStep] = []) {
        self.id = id
        self.dateCreated = dateCreated
        self.journeyName = journeyName
        self.journeyDescription = journeyDescription
        self.steps = steps
    }
}


extension Journey {
    public static func sample() -> Journey {
        let journey =
        Journey(
            journeyName: "Sample Journey",
            steps: []
            )
        
        return journey
    }
    
    public static func sampleNewYork() -> Journey {
        let journey =
        Journey(
            journeyName: "Central Park, New York City",
            journeyDescription: "Central Park is the premier park in New York, New York.",
            steps: []
            )
        
        return journey
    }

}
