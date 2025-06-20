//
//  MediaPickerAndAnnotationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 27/12/2024.
//

import SwiftUI

struct OptionalTextView: View {
    @Binding var text: String?

    @State var nonOptionalText: String

    let title: String

    init(text: Binding<String?>, title: String) {
        _text = text
        nonOptionalText = text.wrappedValue ?? ""
        self.title = title
    }

    var body: some View {
        TextField(title, text: $nonOptionalText, axis: .vertical)
            .onChange(of: nonOptionalText) {
                if nonOptionalText == "" {
                    text = nil
                } else {
                    text = nonOptionalText
                }
            }
    }
}

struct MediaPickerAndAnnotationView<Content: View, SomePickerItem: PickerItem>: PickerSheetView {
    var sheetTitle: String

    let theContent: Content

    init(sheetTitle: String, model: Binding<SomePickerItem>, @ViewBuilder theContent: () -> Content) {
        self.theContent = theContent()
        _model = model
        self.sheetTitle = sheetTitle
    }

    @Binding var model: SomePickerItem

    var content: some View {
        Form {
            Section("Title") {
                OptionalTextView(text: $model.selectedItemText, title: "Title")
            }
            Section("Resource Details") {
                ResourcePicker(model: $model)
                if model.selectedItem != nil {
                    Button("Clear", role: .destructive) {
                        model.clearItem()
                    }
                }
            }
            theContent
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                .removeListRowPaddingInsets()
        }
    }
}
