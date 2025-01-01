//
//  VisualResource.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/12/2024.
//

import Foundation
import SwiftData

@Model
class VisualResource {
    var id: UUID
    var aidDescription: String?
    var timestamp: Date
    private(set) var resourceType: VisualResourceType

    @Attribute(.externalStorage)
    var resourceData: Data
    
    
//    @Relationship(deleteRule: .nullify, inverse: \JourneyStep.visualResource) var steps: [JourneyStep]

    

    init(resourceData: Data, resourceType: VisualResourceType, aidDescription: String? = nil, steps : [JourneyStep] = []) {
        id = UUID()
        timestamp = Date()
        self.resourceData = resourceData
        self.resourceType = resourceType
        self.aidDescription = aidDescription
      //  self.steps = steps
    }
}
