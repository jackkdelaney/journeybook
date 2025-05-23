//
//  PhoneNumberAndCodeSelectionGetterTest.swift
//  AppExtensionJBKit
//
//  Created by Jack Delaney on 18/04/2025.
//

import SharedPersistenceKit
import Testing

@testable import JourneyBook
import SwiftUI

struct PhoneNumberAndCodeSelectionGetterTests {
    @Test
    func initialisationSetsPropertiesCorrectly() {
        let binding = Binding<PhoneNumber?>(
            get: { nil },
            set: { _ in }
        )
        let item = PhoneNumberAndCodeSelectionGetter(phoneNumber: binding)
        #expect(item.phoneNumber.wrappedValue == binding.wrappedValue)
    }

    @Test
    func initialisationSetsPropertiesCorrectlyWithID() {
        let id = UUID()
        let binding = Binding<PhoneNumber?>(
            get: { nil },
            set: { _ in }
        )
        let item = PhoneNumberAndCodeSelectionGetter(id: id, phoneNumber: binding)
        #expect(item.id == id)
        #expect(item.phoneNumber.wrappedValue == binding.wrappedValue)
    }

    @Test
    func hasherFunction() {
        let id = UUID()
        let binding1 = Binding<PhoneNumber?>(
            get: { nil },
            set: { _ in }
        )
        let binding2 = Binding<PhoneNumber?>(
            get: { nil },
            set: { _ in }
        )
        let getterA = PhoneNumberAndCodeSelectionGetter(id: id, phoneNumber: binding1)
        let getterB = PhoneNumberAndCodeSelectionGetter(id: id, phoneNumber: binding2)

        #expect(getterA.id == id)
        #expect(getterB.id == id)
        #expect(getterB.hashValue == getterA.hashValue)
    }
}
