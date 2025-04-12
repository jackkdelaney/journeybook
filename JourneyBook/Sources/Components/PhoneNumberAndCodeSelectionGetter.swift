//
//  PhoneNumberAndCodeSelectionGetter.swift
//  JourneyBook
//
//  Created by Jack Delaney on 13/03/2025.
//

import SwiftUI
import SharedPersistenceKit

struct PhoneNumberAndCodeSelectionGetter: Identifiable, Hashable, Equatable {
    var id: UUID
    var phoneNumber: Binding<PhoneNumber?>

    init(id: UUID = UUID(), phoneNumber: Binding<PhoneNumber?>) {
        self.id = id
        self.phoneNumber = phoneNumber
    }

    static func == (lhs: PhoneNumberAndCodeSelectionGetter, rhs: PhoneNumberAndCodeSelectionGetter) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
