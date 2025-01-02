//
//  JourneyStepSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI

enum JourneyStepSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case addNewStep(Journey)
}

extension JourneyStepSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .addNewStep(journey):
            AddNewJourneyStepView(journey: journey)
        }
    }
}
