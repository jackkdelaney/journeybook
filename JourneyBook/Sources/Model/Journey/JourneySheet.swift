//
//  JourneySheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import SwiftUI

enum WorldSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case addNewJourney
    case tempMapSelector
}

extension WorldSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addNewJourney: AddNewJourneySheet()
        case .tempMapSelector: LocationFindView()
        }
    }
}
