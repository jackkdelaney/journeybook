//
//  PhotosView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 22/12/2024.
//

import SwiftUI
import SwiftData


struct PhotosPickerView: SheetView {
    var sheetTitle: String = "Select Photo"
    
    @State internal var model = PhotosPickerViewModel()
  
    
    @Query var resources: [VisualResource]
    @Environment(\.modelContext) var context


    
    @ViewBuilder
    var topView : some View {
        if let image = model.selectedItem {
            Image(uiImage: image)
                .resizable()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(.container)
        }
        
    }
    
    var content: some View {
        ScrollView {
            topView

            ResourcePicker(model: $model)


        }
    }
}

#Preview {
    PhotosPickerView()
}
