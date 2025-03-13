//
//  CommunicationViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import Observation
import SwiftData
import SwiftUI

@Observable
class CommunicationViewModel {
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var title: String
    var phoneNumber: PhoneNumber?

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
            set: { if $0.isEmpty {
                self.emailAddress = nil
            } else {
                self.emailAddress = $0
            } }
        )
    }

    var phoneNumberBinding: Binding<PhoneNumber?> {
        Binding<PhoneNumber?>(
            get: { self.phoneNumber },
            set: { self.phoneNumber = $0
            }
        )
    }

    var messsageBinding: Binding<String> {
        Binding<String>(
            get: { self.message ?? "" },
            set: { if $0.isEmpty {
                self.message = nil
            } else {
                self.message = $0
            } }
        )
    }

    @MainActor
    init(title: String = "", phoneNumber: PhoneNumber? = nil, emailAddress: String? = nil, message: String? = nil, communictionType: CommunicationType = .phone) {
        self.title = title
        self.communictionType = communictionType
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.message = message

        modelContainer = try! ModelContainer(for: VisualResource.self, Phrase.self, Journey.self, JourneyStep.self, TransportRoute.self, Communiction.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        modelContext = modelContainer.mainContext
    }

    func saveItem() throws {
        if title == "" {
            throw CommunicationViewModelError.noTitleText
        }
        do {
            let communication = try makeCommuniction()
            add(communication)
        } catch {
            throw error
        }
    }

    private func makeCommuniction() throws -> Communiction {
        switch communictionType {
        case .phone:
            if let phoneNumber {
                return Communiction(title: title, phoneNumber: phoneNumber)
            } else {
                throw CommunicationViewModelError.noPhoneNumber
            }
        case .email:
            if let emailAddress, let message {
                return Communiction(title: title, email: emailAddress, message: message)
            } else {
                throw CommunicationViewModelError.noEmailOrMessage
            }
        case .message:
            if let phoneNumber, let message {
                return Communiction(title: title, phoneNumber: phoneNumber, message: message)
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

extension CommunicationViewModel {
    func fetchResources() -> [Communiction] {
        do {
            return try modelContext.fetch(FetchDescriptor<Communiction>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(_ communication: Communiction) {
        modelContext.insert(communication)
        do {
            try modelContext.save()

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
