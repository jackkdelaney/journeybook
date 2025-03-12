//
//  AddNewCommunicationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI

struct AddNewCommunicationView: SheetView {
    var content: some View {
        Text("Content")
    }

    var confirmButton: some View {
        Button("Add") {}
    }

    var sheetTitle: String {
        "Add Communication"
    }
}

struct CommunicationEditSheet: SheetView {
    @Bindable var communication: Communiction

    var content: some View {
        Text("Hello, World!")
    }

    var confirmButton: some View {
        Button("Update") {}
    }

    var sheetTitle: String {
        "Edit Communication"
    }
}
