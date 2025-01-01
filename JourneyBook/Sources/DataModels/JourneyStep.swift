//
//  JourneyStep.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import Foundation
import SwiftData

@Model
class JourneyStep {
    private(set) var id: UUID
    private(set) var dateCreated: Date
    var stepName: String
    var stepDescription: String?
    
    var journey: Journey?

    var orderIndex: Int
    
    init(id: UUID = UUID(), dateCreated: Date = Date.now, stepName: String, stepDescription: String? = nil,journey : Journey) {
        //VisualResource? = nil
        self.id = id
        self.dateCreated = dateCreated
        self.stepName = stepName
        self.stepDescription = stepDescription
        self.orderIndex = journey.steps.count + 1
        self.journey = journey
    }
    
}
