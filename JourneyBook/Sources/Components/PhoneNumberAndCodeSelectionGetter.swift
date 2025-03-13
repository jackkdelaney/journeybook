//
//  PhoneNumberAndCodeSelectionGetter.swift
//  JourneyBook
//
//  Created by Jack Delaney on 13/03/2025.
//

import SwiftUI

struct PhoneNumberAndCodeSelectionGetter: Identifiable, Hashable, Equatable {
    var id: UUID
    var countryCode: Binding<CountryWithCode?>

    init(id: UUID = UUID(), countryCode: Binding<CountryWithCode?>) {
        self.id = id
        self.countryCode = countryCode
    }

    static func == (lhs: PhoneNumberAndCodeSelectionGetter, rhs: PhoneNumberAndCodeSelectionGetter) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
