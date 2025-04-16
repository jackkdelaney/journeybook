//
//  CommunicationDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI
import SharedPersistenceKit

struct CommunicationDetailView: View {
    @Bindable var communication: Communication

    @State var sheet: CommunicationSheet? = nil

    let inSheet: Bool

    var body: some View {
        if inSheet {
            CommunicationEditSheet(communication: communication)
        } else {
            viewMode
        }
    }

    var viewMode: some View {
        Form {
            specialisedSection
            Section("Communication Details") {
                LabeledContent {
                    Text(communication.dateModified.formatted())
                }
                label: {
                    Text("Last Updated")
                }
                LabeledContent {
                    Text(communication.dateCreated.formatted())
                }
                label: {
                    Text("Created")
                }
                LabeledContent {
                    Text(communication.communictionType.stringName)
                }
                label: {
                    Text("Type")
                }
            }
        }
        .navigationTitle(communication.title)
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    sheet = .editCommunication(communication)
                } label: {
                    Text("Edit")
                }
            }
        }
    }

    @ViewBuilder
    private var specialisedSection: some View {
        if communication.communictionType == .phone, let phoneNumber = communication.phoneNumber {
            Section("Phone Number Details") {
                phoneNumberView(for: phoneNumber)
            }
        } else if communication.communictionType == .message, let phoneNumber = communication.phoneNumber, let message = communication.message {
            Section(header: Text("Message Details"), footer: Text("You message is \(message.count) characters in length.")) {
                phoneNumberView(for: phoneNumber)
                messsageView(for: message)
            }

            Section {
                MessageButtonView(recipients: [phoneNumber.formattedPhoneNumber], message: message)
            }
        } else if communication.communictionType == .email, let email = communication.emailAddress, let message = communication.message {
            Section(header: Text("Email Details"), footer: Text("You message is \(message.count) characters in length.")) {
                emailView(for: email)
                messsageView(for: message)

                MailButton(email: email, buttonTitle: "Send Email", content: message)
            }
        }
    }

    @ViewBuilder
    private func phoneNumberView(for phoneNumber: PhoneNumber) -> some View {
        LabeledContent {
            Link(phoneNumber.formattedPhoneNumber, destination: URL(string: "tel://\(phoneNumber.formattedPhoneNumber)")!)
        }
        label: {
            Text("Phone Number")
        }
    }

    @ViewBuilder
    private func messsageView(for message: String) -> some View {
        Text(message)
            .multilineTextAlignment(.leading)
    }

    @ViewBuilder
    private func emailView(for email: String) -> some View {
        LabeledContent {
            Text(email)
        }
        label: {
            Text("Email")
        }
    }
}
