//
//  ResourcePicker.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/12/2024.
//

import SwiftUI
import PhotosUI

struct ResourcePicker<Item: PickerItem>: View {
    typealias Item = PickerItem
    
    @Binding var model: Item
    
    var body : some View {
        PhotosPicker(model.pickerText, selection: $model.selectedPickerItem, matching: model.filter)
    }
    
    
}
