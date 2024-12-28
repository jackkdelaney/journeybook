//
//  ResourcePicker.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/12/2024.
//

import PhotosUI
import SwiftUI

struct ResourcePicker<Item: PickerItem>: View {
    typealias Item = PickerItem

    @Binding var model: Item

    var pickerText: String {
        if model.selectedItem == nil {
            "Select \(model.pickerText)"
        } else {
            "Change \(model.pickerText)"
        }
    }

    var body: some View {
        PhotosPicker(pickerText, selection: $model.selectedPickerItem, matching: model.filter)
    }
}
