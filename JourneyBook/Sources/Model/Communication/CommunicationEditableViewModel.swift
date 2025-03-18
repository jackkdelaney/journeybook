//
//  CommunicationEditableViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 14/03/2025.
//

import Observation
import SwiftData
import SwiftUI

@Observable
class CommunicationEditableViewModel: CommunictionModel {
    typealias Item = CommunicationEditableViewModel

    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var communication: Communication
    var title: String
    var phoneNumber: PhoneNumber? {
        didSet {
            if let phoneNumberUnWrapped = phoneNumber {
                if phoneNumberUnWrapped.countryCode == nil
                    && phoneNumberUnWrapped.phoneNumber != ""
                {
                    phoneNumber?.phoneNumber = ""
                }
            }
        }
    }

    var emailAddress: String?
    var message: String?

    var communictionType: CommunicationType {
        didSet {
            if communictionType == .phone {
                emailAddress = nil
                message = nil
            }
            if communictionType == .email {
                phoneNumber = nil
            }
            if communictionType == .message {
                emailAddress = nil
            }
        }
    }

    var emailAddresssBinding: Binding<String> {
        Binding<String>(
            get: { self.emailAddress ?? "" },
            set: {
                if $0.isEmpty {
                    self.emailAddress = nil
                } else {
                    self.emailAddress = $0
                }
            }
        )
    }

    var phoneNumberBinding: Binding<PhoneNumber?> {
        Binding<PhoneNumber?>(
            get: { self.phoneNumber },
            set: {
                self.phoneNumber = $0

            }
        )
    }

    var phoneNumberStringBinding: Binding<String> {
        Binding<String>(
            get: { self.phoneNumberBinding.wrappedValue?.phoneNumber ?? "" },
            set: {
                self.phoneNumberBinding.wrappedValue?.phoneNumber = $0
            }
        )
    }

    var messsageBinding: Binding<String> {
        Binding<String>(
            get: { self.message ?? "" },
            set: {
                if $0.isEmpty {
                    self.message = nil
                } else {
                    self.message = $0
                }
            }
        )
    }

    @MainActor
    init(
        communication: Communication
    ) {
        self.title = communication.title
        self.communictionType = communication.communictionType
        self.phoneNumber = communication.phoneNumber
        self.emailAddress = communication.emailAddress
        self.message = communication.emailAddress
        self.communication = communication

        modelContainer = try! ModelContainer(
            for: VisualResource.self, Phrase.self, Journey.self,
            JourneyStep.self, TransportRoute.self, Communication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        modelContext = modelContainer.mainContext
    }

    func saveItem() throws {
        if title == "" {
            throw CommunicationViewModelError.noTitleText
        }
        do {
            _ = try isValid()

            self.communication.title = title
            self.communication.communictionType = communictionType
            self.communication.phoneNumber = phoneNumber
            self.communication.emailAddress = emailAddress
            self.communication.message = emailAddress

            try modelContext.save()
        } catch {
            throw error
        }
    }

    private func isValid() throws -> Bool {
        switch communictionType {
        case .phone:
            if let phoneNumber ,let _ = phoneNumber.countryCode {
                return true
            } else {
                throw CommunicationViewModelError.noPhoneNumber
            }
        case .email:
            if let emailAddress, let message {
                return true
            } else {
                throw CommunicationViewModelError.noEmailOrMessage
            }
        case .message:
            if let phoneNumber, let message,let countryCode = phoneNumber.countryCode {
                return true
            } else {
                throw CommunicationViewModelError.noPhoneOrmessage
            }
        }
    }

    func clearItem() {
        title = ""
        phoneNumber = nil
        emailAddress = nil
        message = nil
    }
}
