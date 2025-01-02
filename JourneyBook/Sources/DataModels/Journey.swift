//
//  Journey.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import Foundation
import SwiftData

@Model
class Journey {
    private(set) var id: UUID
    private(set) var dateCreated: Date
    var journeyName: String
    var journeyDescription: String?

    @Relationship(deleteRule: .nullify, inverse: \JourneyStep.journey) var steps: [JourneyStep]

    init(id: UUID = UUID(), dateCreated: Date = Date.now, journeyName: String, journeyDescription: String? = nil, steps: [JourneyStep] = []) {
        self.id = id
        self.dateCreated = dateCreated
        self.journeyName = journeyName
        self.journeyDescription = journeyDescription
        self.steps = steps
    }
}
