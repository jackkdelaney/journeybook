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
    
    var visualResource : VisualResource?
    
    init(id: UUID, dateCreated: Date, stepName: String, stepDescription: String? = nil, visualResource: VisualResource? = nil) {
        self.id = id
        self.dateCreated = dateCreated
        self.stepName = stepName
        self.stepDescription = stepDescription
        self.visualResource = visualResource
    }
    
}
