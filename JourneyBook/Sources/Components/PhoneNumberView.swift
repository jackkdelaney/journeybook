//
//  PhoneNumberView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI

struct PhoneNumberView: View {
    @Binding var phoneNumber: PhoneNumber?

    @ViewBuilder
    var body: some View {
        if let phoneNumber {
            
        }
    }
}

#Preview {
    List {
        PhoneNumberView(phoneNumber: .constant(PhoneNumber.examplePhoneNumber))
    }
}
