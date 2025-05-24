//
//  CommunictionModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 14/03/2025.
//

import SharedPersistenceKit
import SwiftData
import SwiftUI

protocol CommunictionModel: Observable {
    associatedtype Item

    var modelContainer: ModelContainer { get }
    var modelContext: ModelContext { get }

    var title: String { get set }
    var phoneNumber: PhoneNumber? { get set }
    var emailAddress: String? { get set }
    var message: String? { get set }
    var communictionType: CommunicationType { get set }

    var emailAddresssBinding: Binding<String> { get }
    var phoneNumberBinding: Binding<PhoneNumber?> { get }

    var phoneNumberStringBinding: Binding<String> { get }
    var messsageBinding: Binding<String> { get }

    func saveItem() throws
}
