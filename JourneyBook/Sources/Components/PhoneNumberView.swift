//
//  PhoneNumberView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI

@Observable
class PhoneNumberViewModel {
    private var phoneNumber: Binding<PhoneNumber?>

    var countryCode: CountryWithCode? {
        didSet {
            if let countryCode {
                if let number = phoneNumber.wrappedValue {
                    phoneNumber.wrappedValue?.countryCode = countryCode
                } else {
                    phoneNumber.wrappedValue = PhoneNumber(countryCode: countryCode, phoneNumber: phoneNumberString)
                }
            } else {
                phoneNumber.wrappedValue = nil
            }
        }
    }

    var phoneNumberString: String {
        didSet {
            if let number = phoneNumber.wrappedValue {
                phoneNumber.wrappedValue?.phoneNumber = phoneNumberString
            }
        }
    }

    var showPhoneNumber: Bool {
        countryCode != nil
    }

    init(phoneNumber: Binding<PhoneNumber?>) {
        self.phoneNumber = phoneNumber
        if let number = phoneNumber.wrappedValue {
            countryCode = number.countryCode
            phoneNumberString = number.phoneNumber
        } else {
            countryCode = nil
            phoneNumberString = ""
        }
    }
}

struct PhoneNumberView: View {
    @State private var viewModel: PhoneNumberViewModel
    @State private var sheet: ComponentsSheet? = nil

    @Binding var phoneNumber: PhoneNumber?

    init(phoneNumber: Binding<PhoneNumber?>) {
        _phoneNumber = phoneNumber
        _viewModel = State(initialValue: PhoneNumberViewModel(phoneNumber: phoneNumber))
    }

    var body: some View {
        contents

            .sheet(item: $sheet) { item in
                item.buildView()
            }
    }

    @ViewBuilder
    var contents: some View {
        if phoneNumber != nil {
            LabeledContent {
                Button {
                    sheet = .countrycodeSelection($viewModel.countryCode)
                } label: {
                    if let code = $viewModel.countryCode.wrappedValue {
                        Text("\(code.countryCode) (\(code.dialCode)")
                    }
                }
            } label: {
                Text("Phone")
            }
            if viewModel.showPhoneNumber {
                Text("TYPE PHONE NUMBER HERE")
            }
        } else {
            Button {
                sheet = .countrycodeSelection($viewModel.countryCode)
            } label: {
                Text("Select Country Code")
            }
        }
    }
}
