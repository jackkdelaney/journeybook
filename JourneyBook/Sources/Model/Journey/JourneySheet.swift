//
//  JourneySheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import SharedPersistenceKit
import SwiftUI

enum JourneySheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case addNewJourney
    case editJourney(Journey)
    case editJourneyStep(JourneyStep)
}

extension JourneySheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addNewJourney: AddNewJourneySheet()
        case let .editJourney(journey):
            EditExistingJourneySheet(journey: journey)
        case let .editJourneyStep(journeyStep):
            EditExistingJourneyStepSheet(journeyStep: journeyStep)
        }
    }
}
