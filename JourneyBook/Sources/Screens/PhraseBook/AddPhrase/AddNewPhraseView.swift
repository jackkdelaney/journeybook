//
//  AddNewPhraseView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SwiftUI

struct AddNewPhraseView: SheetView {
    var sheetTitle: String {
        "Add New Phrase"
    }

    @Environment(\.dismiss) var dismiss

    @State var model = PhraseModel()

    @State private var errorMessage: PhraseModelError?

    var content: some View {
        Form {
            Section("Phrase Text") {
                TextField("Phrase Text", text: $model.text, axis: .vertical)
                    .lineLimit(3...6)
            }
            
            Section("Background Colour") {
                ColorPicker("Background Colour", selection: $model.colour)
            }

            Section("Try it") {
                SinglePressButtonForSpeak(text: $model.text) {
                    Text("Try it here")
                }
                .disabled(model.text.isEmpty)
            }
        }
        .alert(item: $errorMessage) { error in
            Alert(
                title: Text("Could Not Save"),
                message: Text(error.errorMessage), dismissButton: .cancel())
        }
    }

    var confirmButton: some View {
        Button("Add") {
            do {
                try model.saveItem()
                dismiss()
            } catch PhraseModelError.noText {
                errorMessage = .noText
            } catch {
                print(error)
            }
        }
    }

}
