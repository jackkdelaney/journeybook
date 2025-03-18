//
//  CommunictionViewContent.swift
//  JourneyBook
//
//  Created by Jack Delaney on 14/03/2025.
//

import SwiftUI

struct CommunictionViewContent<Model: CommunictionModel>: View {
    typealias Model = PickerItem

    @Binding var viewModel: Model

    @State private var sheet: ComponentsSheet? = nil

    @Binding var errorMessage: CommunicationViewModelError?

    var body: some View {
        Form {
            Section {
                communicationType
                LabeledContent {
                    TextField("Title", text: $viewModel.title)
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("Title")
                }
            }
            contentSection
        }
        .alert(item: $errorMessage) { error in
            Alert(
                title: Text("Could Not Save"),
                message: Text(error.errorMessage), dismissButton: .cancel())
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
    }

    private var communicationType: some View {
        Picker(
            "Type",
            selection: $viewModel.communictionType,
            content: {
                ForEach(CommunicationType.allCases, id: \.self) {
                    Text($0.stringName)
                }
            })
    }

    @ViewBuilder
    private var contentSection: some View {
        Section {
            if viewModel.communictionType == .email {
                LabeledContent {
                    TextField("Email", text: viewModel.emailAddresssBinding)
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("Email")
                }
            }
        }
        if viewModel.communictionType != .email {
            countryCodeAndPhoneNumberEntry
        }

        if viewModel.communictionType != .phone {
            Section("Message") {
                TextEditor(text: viewModel.messsageBinding)
                    .multilineTextAlignment(.leading)
            }
        }
    }

    @ViewBuilder
    private var countryCodeAndPhoneNumberEntry: some View {
        Section("Phone Number") {
            LabeledContent {
                Button {
                    let sheetWrapped = PhoneNumberAndCodeSelectionGetter(
                        phoneNumber: viewModel.phoneNumberBinding)

                    sheet = .countrycodeSelection(sheetWrapped)
                } label: {
                    if let code = viewModel.phoneNumberBinding.wrappedValue?
                        .countryCode
                    {
                        Text("\(code.countryName) (\(code.dialCode))")
                    } else {
                        Text("No Selection")
                    }

                }
            } label: {
                Text("Phone Dialing Code")
            }
            if viewModel.phoneNumberBinding.wrappedValue?.countryCode != nil {
                LabeledContent {
                    TextField(
                        "Phone Number", text: viewModel.phoneNumberStringBinding
                    )
                    .multilineTextAlignment(.trailing)
                } label: {
                    Text("Phone Number")
                }
            }
        }
    }

}
