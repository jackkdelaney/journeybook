//
//  JourneySheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import SwiftUI

enum JourneySheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case addNewJourney
}

extension JourneySheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addNewJourney: AddNewJourneySheet()
        }
    }
}
