//
//  AddNewCommunicationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI

struct AddNewCommunicationView: CommunictionSheetView {
    @Environment(\.dismiss) var dismiss

    @State var viewModel = CommunicationViewModel()

    @State var errorMessage: CommunicationViewModelError?

    var content: some View {
        contentView(for: $viewModel, withError: $errorMessage)
    }

    func dismissView() {
        dismiss()
    }

    func setError(for error: CommunicationViewModelError) {
        self.errorMessage = error
    }

    var sheetTitle: String {
        "Add Communication"
    }

    var confirmButtonTitleText: String {
        "Add"
    }
}
