//
//  VisualResource.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/12/2024.
//

import Foundation
import SwiftData

@Model
public class VisualResource {
    public var id: UUID
    public var aidDescription: String?
    public var timestamp: Date
    public private(set) var resourceType: VisualResourceType

    @Attribute(.externalStorage)
    public var resourceData: Data

    @Relationship(inverse: \JourneyStep.visualResources) public var steps: [JourneyStep]

    public init(resourceData: Data, resourceType: VisualResourceType, aidDescription: String? = nil, steps: [JourneyStep] = []) {
        id = UUID()
        timestamp = Date()
        self.resourceData = resourceData
        self.resourceType = resourceType
        self.aidDescription = aidDescription
        self.steps = steps
    }
}
