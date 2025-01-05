//
//  TransportRoute.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/01/2025.
//

import SwiftData
import Foundation


@Model
class TransportRoute {
    private(set) var id: UUID
    private(set) var url : URL
    private(set) var dateCreated : Date?
    
    var routeName: String
    
    @Relationship(deleteRule: .nullify, inverse: \JourneyStep.route)
    var steps: [JourneyStep]

    
    
    init(id: UUID, routeName: String, url: URL,steps: [JourneyStep] = []) {
        self.id = id
        self.routeName = routeName
        self.url = url
        self.dateCreated = Date.now
        self.steps = steps
    }
    
}
