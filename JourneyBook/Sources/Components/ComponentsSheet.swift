//
//  ComponentsSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import Foundation
import SwiftUI

enum ComponentsSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case countrycodeSelection(Binding<CountryWithCode?>)

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ComponentsSheet: Equatable {
    static func == (lhs: ComponentsSheet, rhs: ComponentsSheet) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension ComponentsSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .countrycodeSelection(countryCode):
            CountryCodeSelectorDetailView(countryCode: countryCode)
        }
    }
}
