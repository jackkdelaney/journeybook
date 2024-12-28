//
//  SheetView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import SwiftUI

protocol SheetView: View {
    var sheetTitle: String { get }

    associatedtype Content: View
    associatedtype ConfirmButton: View

    var content: Content { get }

    var confirmButton: ConfirmButton { get }
}

protocol PickerSheetView: SheetView {
    associatedtype PickerViewModel: PickerItem
    var model: PickerViewModel { get }
}

extension PickerSheetView {
    var confirmButton: some View {
        AddButtonForPickerItem(model: model)
    }
}

extension SheetView {
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(sheetTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        CancelButton()
                    }
                    ToolbarItem(placement: .primaryAction) {
                        confirmButton
                    }
                }
        }
        .interactiveDismissDisabled(true)
    }
}
