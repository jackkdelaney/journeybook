//
//  JourneyStepSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI
import SharedPersistenceKit

enum JourneyStepSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case addNewStep(Journey)
    case editJourney(Journey)
}

extension JourneyStepSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .addNewStep(journey):
            AddNewJourneyStepView(journey: journey)
        case let .editJourney(journey):
            EditExistingJourneySheet(journey: journey)
        }
    }
}
