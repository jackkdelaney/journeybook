//
//  MediaPickerAndAnnotationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 27/12/2024.
//

import SwiftUI

struct OptionalTextView :  View {
    @Binding var text: String?
    
    @State var nonOptionalText : String
    
    let title : String
    
    init(text: Binding<String?>, title: String) {
        self._text = text
        self.nonOptionalText = text.wrappedValue ?? ""
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
            TextField(title, text: $nonOptionalText, axis: .vertical)
        }
        .onChange(of: nonOptionalText) {
            if nonOptionalText == "" {
                text = nil
            } else {
                text = nonOptionalText
            }
        }
        
    }
}

struct MediaPickerAndAnnotationView<Content: View, SomePickerItem: PickerItem> : PickerSheetView {
    
    var sheetTitle: String
    
    let theContent: Content
    
    init(sheetTitle: String,model : Binding<SomePickerItem>, @ViewBuilder theContent: () -> Content) {
        self.theContent = theContent()
        self._model = model
        self.sheetTitle = sheetTitle
    }
    
    @Binding internal var model : SomePickerItem
    
    
    
    var content : some View {
        Form {
            Section("Title") {
                OptionalTextView(text: $model.selectedItemText, title: "Title")
            }
            Section("Resource Details") {
                ResourcePicker(model: $model)
                if model.selectedItem != nil {
                    Button("Clear",role: .destructive) {
                        model.clearItem()
                    }
                }
            }
            theContent
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    
}
