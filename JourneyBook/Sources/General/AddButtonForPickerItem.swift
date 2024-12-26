//
//  AddButtonForPickerItem.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI

struct AddButtonForPickerItem<SomePickerItem : PickerItem> : View {
    @Environment(\.dismiss) var dismiss
    
    var model : SomePickerItem

    var body: some View {
        Button("Add") {
            model.saveItem()
            dismiss()
        }
        .disabled(model.selectedItem == nil)
    }
}
