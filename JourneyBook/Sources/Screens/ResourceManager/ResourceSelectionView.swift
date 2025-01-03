//
//  ResourceSelectionView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/01/2025.
//

import SwiftUI
import SwiftData

struct ResourceSelectionView : SheetView {
    @Environment(\.dismiss) var dismiss

    @Binding var selection: VisualResource?
    
    @Query var resources: [VisualResource]

    
    var content: some View {
        List {
            ForEach(resources) { resource in
                HStack {
                    Button {
                        selection = resource
                    } label: {
                        Text(resource.aidDescription ?? "Unamed Item")
                    }
                    .chevronButtonStyle()
                }
            }
        }
    }
    
 
    
    var confirmButton: some View {
        Button("Save"){
            dismiss()
        }
        .disabled(selection == nil)
    }
    
    var sheetTitle: String {
        "Select a Resource"
    }
    
}

