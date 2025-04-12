//
//  JourneyStep.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import Foundation
import SwiftData

@Model
public class JourneyStep {
    public private(set) var id: UUID
    private(set) var dateCreated: Date
    public var stepName: String
    public var stepDescription: String?

    public var journey: Journey?
    public var orderIndex: Int

    // MARK: LOCATION

    public var location: JourneyStepLocation?

    // MARK: VISUAL RESOURCE

    public var visualResources: [VisualResource]

    public var route: TransportRoute?

    public var phrases: [Phrase]

    public var communication: Communication?

    public init(
        id: UUID = UUID(),
        dateCreated: Date = Date.now,
        stepName: String,
        stepDescription: String? = nil,
        journey: Journey,
        location: JourneyStepLocation? = nil,
        communication _: Communication? = nil,
        visualResources: [VisualResource] = [],
        route: TransportRoute? = nil,
        phrases: [Phrase] = []
    ) {
        self.id = id
        self.dateCreated = dateCreated
        self.stepName = stepName
        self.stepDescription = stepDescription
        orderIndex = journey.steps.count + 1
        self.journey = journey
        self.location = location
        self.visualResources = visualResources
        self.route = route
        self.phrases = phrases
    }
}
