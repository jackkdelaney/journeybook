//
//  PhotosView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 22/12/2024.
//

import SwiftData
import SwiftUI

struct PhotosPickerView: MediaPickerView {
    var sheetTitle: String = "Select Photo"

    @State var model = PhotosPickerViewModel()

    @ViewBuilder
    var topView: some View {
        if let image = model.selectedItem {
            Image(uiImage: image)
                .resizable()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(.container)
        }
    }

    var body: some View {
        MediaPickerAndAnnotationView(sheetTitle: sheetTitle, model: $model) {
            topView
        }
    }
}

#Preview {
    PhotosPickerView()
}
