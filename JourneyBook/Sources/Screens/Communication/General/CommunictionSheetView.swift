//
//  CommunictionSheetView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 14/03/2025.
//

import SwiftUI

protocol CommunictionSheetView: SheetView {
    associatedtype CommunictionViewModelType: CommunictionModel

    var viewModel: CommunictionViewModelType { get }
    var errorMessage: CommunicationViewModelError? { get set }

    var confirmButtonTitleText: String { get }

    var sheetTitle: String { get }

    func dismissView()
    func setError(for error: CommunicationViewModelError)
}

extension CommunictionSheetView {
    func contentView(
        for viewModel: Binding<CommunictionViewModelType>,
        withError error: Binding<CommunicationViewModelError?>
    ) -> some View {
        CommunictionViewContent(viewModel: viewModel, errorMessage: error)
    }

    var confirmButton: some View {
        Button(confirmButtonTitleText) {
            do {
                try viewModel.saveItem()
                dismissView()
            } catch let error as CommunicationViewModelError {
                setError(for: error)
            } catch {
                print(error)
            }
        }
    }
}
