//
//  CommunicationEditSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 14/03/2025.
//

import SwiftUI

struct CommunicationEditSheet: CommunictionSheetView {
    @Environment(\.dismiss) var dismiss

    @State var viewModel: CommunicationEditableViewModel

    init(communication: Communication) {
        viewModel = CommunicationEditableViewModel(communication: communication)
    }

    @State var errorMessage: CommunicationViewModelError?

    var content: some View {
        contentView(for: $viewModel, withError: $errorMessage)
    }

    func dismissView() {
        dismiss()
    }

    func setError(for error: CommunicationViewModelError) {
        errorMessage = error
    }

    var confirmButtonTitleText: String {
        "Update"
    }

    var sheetTitle: String {
        "Edit Communication"
    }
}
