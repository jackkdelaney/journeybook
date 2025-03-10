//
//  EditPhraseView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SwiftUI

struct EditPhraseView: SheetView {
    var sheetTitle: String {
        "Edit Phrase"
    }

    @Environment(\.dismiss) var dismiss

    @State var model : CurrentPhraseViewModel
    
    init(phrase: Phrase) {
        self.model = CurrentPhraseViewModel(phrase: phrase)
    }

    @State private var errorMessage: PhraseModelError?

    var content: some View {
        Form {
            Section("Phrase Text") {
                TextField("Phrase Text", text: $model.text)
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
        Button("Edit") {
            do {
                try model.save()
                dismiss()
            } catch PhraseModelError.noText {
                errorMessage = .noText
            } catch {
                print(error)
            }
        }
    }

}
