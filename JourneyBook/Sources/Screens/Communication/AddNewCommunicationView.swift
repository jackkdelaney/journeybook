//
//  AddNewCommunicationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI

struct AddNewCommunicationView: SheetView {
    @State private var viewModel = CommunicationViewModel()

    @State private var sheet: ComponentsSheet? = nil

    var content: some View {
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
        .sheet(item: $sheet) { item in
            item.buildView()
        }
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
            if viewModel.communictionType != .email {
                countryCodeAndPhoneNumberEntry
            }
        }
        if viewModel.communictionType != .phone {
            Section("Message") {
                TextEditor(text: viewModel.messsageBinding)
                    .multilineTextAlignment(.leading)
            }
        }
    }

    private var countryCodeAndPhoneNumberEntry: some View {
        LabeledContent {
            Button {
                let sheetWrapped = PhoneNumberAndCodeSelectionGetter(
                    countryCode: viewModel.countyWithCodeBinding)

                sheet = .countrycodeSelection(sheetWrapped)
            } label: {
                if let code = viewModel.countyWithCodeBinding.wrappedValue {
                    Text("\(code.countryCode) (\(code.dialCode)")
                } else {
                    Text("No Selection")
                }
            }
        } label: {
            Text("Phone")
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

    var confirmButton: some View {
        Button("Add") {}
    }

    var sheetTitle: String {
        "Add Communication"
    }
}

struct CommunicationEditSheet: SheetView {
    @Bindable var communication: Communiction

    var content: some View {
        Text("Hello, World!")
    }

    var confirmButton: some View {
        Button("Update") {}
    }

    var sheetTitle: String {
        "Edit Communication"
    }
}
