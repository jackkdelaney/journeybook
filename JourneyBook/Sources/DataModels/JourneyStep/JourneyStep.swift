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

    init(
        id: UUID = UUID(),
        dateCreated: Date = Date.now,
        stepName: String,
        stepDescription: String? = nil,
        journey: Journey,
        location: JourneyStepLocation? = nil,
        communication: Communication? = nil,
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

    // MARK: LOCATION

    var location: JourneyStepLocation?

    // MARK: VISUAL RESOURCE

    var visualResources: [VisualResource]

    var route: TransportRoute?

    var phrases: [Phrase]

    var communication: Communication?

}
