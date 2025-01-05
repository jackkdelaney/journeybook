//
//  AddTransportRouteView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct AddTransportRouteView : SheetView {
    var confirmButton: some View {
        Text("CONFIRM")
    }
    
    var sheetTitle: String {
        "Add New Route"
    }
    var content: some View {
        Form {
            Text("Content")
        }
    }
}
