//
//  SheetView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import SwiftUI

protocol SheetView : View {
    var sheetTitle: String { get }
    
    associatedtype Content : View
    associatedtype PickerViewModel : PickerItem
    
    var content : Content { get }
    
    var model : PickerViewModel {get }
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
                        AddButtonForPickerItem(model: model)
                    }
                }
            
        }
        .interactiveDismissDisabled(true)

    }
    
}
