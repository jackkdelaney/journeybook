//
//  TransportRoute.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/01/2025.
//

import Foundation
import SwiftData

@Model
public class TransportRoute {
    public private(set) var id: UUID
    public private(set) var url: URL
    public private(set) var dateCreated: Date?

    public var routeName: String

    @Relationship(deleteRule: .nullify, inverse: \JourneyStep.route)
    public var steps: [JourneyStep]

    public init(id: UUID = UUID(), routeName: String, url: URL, steps: [JourneyStep] = []) {
        self.id = id
        self.routeName = routeName
        self.url = url
        dateCreated = Date.now
        self.steps = steps
    }
}
