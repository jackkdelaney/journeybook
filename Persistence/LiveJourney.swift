//
//  LiveJourney.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/04/2025.
//

import Foundation
import SwiftData

@Model
public class LiveJourney {
    public private(set) var id: UUID

    private(set) var dateUpdated: Date

    public var journey: Journey?

    public var stepNumber: Int

    public var stepsAmount: Int {
        if let journey {
            return journey.steps.count
        }
        return 0
    }

    var currentStep: JourneyStep? {
        if let journey {
            let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
            if sortedLocalList.indices.contains(stepNumber) {
                return sortedLocalList[stepNumber]
            }
        }
        return nil
    }

    public init(
        id: UUID = UUID(),
        dateUpdated: Date = Date.now,
        journey: Journey? = nil
    ) {
        self.id = id
        self.dateUpdated = dateUpdated
        self.journey = journey
        if journey?.steps.count ?? 0 > 0 {
            stepNumber = 1
        } else {
            stepNumber = 0
        }
    }
}
