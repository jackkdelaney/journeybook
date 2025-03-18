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

    case countrycodeSelection(PhoneNumberAndCodeSelectionGetter)

}


extension ComponentsSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .countrycodeSelection(getter):
            CountryCodeSelectorDetailView(phoneNumber: getter.phoneNumber)
        }
    }
}
