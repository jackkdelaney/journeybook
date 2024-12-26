//
//  CancelButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI

struct CancelButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Cancel",role: .cancel) {
            dismiss()
        }
    }
}
