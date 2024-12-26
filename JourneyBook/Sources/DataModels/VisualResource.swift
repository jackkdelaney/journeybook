//
//  VisualResource.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/12/2024.
//

import SwiftData
import Foundation

@Model
class VisualResource {
    var id : UUID
    var aidDescription : String?
    var timestamp: Date
    var resourceType : VisualResourceType
    
    
    @Attribute(.externalStorage)
    var resourceData: Data
    
    init(resourceData: Data,resourceType : VisualResourceType, aidDescription : String? = nil) {
        self.id = UUID()
        self.timestamp = Date()
        self.resourceData = resourceData
        self.resourceType = resourceType
        self.aidDescription = aidDescription
    }
}
