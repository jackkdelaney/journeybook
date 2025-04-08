//
//  LiveJourney.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/04/2025.
//

import Foundation
import SwiftData

@Model
class LiveJourney {
    private(set) var id: UUID
    private(set) var dateUpdated: Date

    var journey: Journey?

    var stepNumber: Int
    
    var stepsAmount : Int {
        if let journey {
            return journey.steps.count
        }
        return 0
    }

    var currentStep: JourneyStep? {
        if let journey {
            let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
            return sortedLocalList[stepNumber]
        }
        return nil
    }

    init(
        id: UUID = UUID(),
        dateUpdated: Date = Date.now,
        journey: Journey? = nil
    ) {
        self.id = id
        self.dateUpdated = dateUpdated
        self.journey = journey
        stepNumber = 0
    }

}

//@Model
//class Journey {
//    private(set) var id: UUID
//    private(set) var dateCreated: Date
//    var journeyName: String
//    var journeyDescription: String?
//
//    @Relationship(deleteRule: .nullify, inverse: \JourneyStep.journey) var steps: [JourneyStep]
//
//    init(id: UUID = UUID(), dateCreated: Date = Date.now, journeyName: String, journeyDescription: String? = nil, steps: [JourneyStep] = []) {
//        self.id = id
//        self.dateCreated = dateCreated
//        self.journeyName = journeyName
//        self.journeyDescription = journeyDescription
//        self.steps = steps
//    }
//}
