//
//  AddNewJourneySheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import SwiftUI

struct AddNewJourneySheet: SheetView {
    var sheetTitle: String {
        "Add New Journey"
    }
    @Environment(\.dismiss) var dismiss

    @State var model = JourneyViewModel()

    @State private var errorMessage: JourneyViewModelError?

    
    var content: some View {
        Form {
            Section("Journey Name") {
                TextField("Journey Name", text: $model.journeyName)
            }
            Section("Journey Description") {
                TextEditor(text: journeyDescription)

            }
        }
        .alert(item: $errorMessage) { error in
            Alert(title: Text("Could Not Save"), message: Text(error.errorMessage), dismissButton: .cancel())
        }
    }

    var confirmButton: some View {
        Button("Add") {
            do {
                try model.saveItem()
                dismiss()
            }
            catch JourneyViewModelError.noJourneyText {
                errorMessage = .noJourneyText
            }
            catch {
                print(error)
            }
        }
    }

    private var journeyDescription: Binding<String> {
        Binding(
            get: { self.model.journeyDescription ?? "" },
            set: {
                if $0 == "" {
                    self.model.journeyDescription = nil
                } else {
                    self.model.journeyDescription = $0
                }
            }
        )
    }

}
