//
//  PhraseEditSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 29/12/2024.
//
import SwiftUI

struct PhraseEditSheet: SheetView {
    @Environment(\.dismiss) var dismiss

    var confirmButton: some View {
        
        Button("Confirm") {
            dismiss()
        }
    }

    var sheetTitle: String {
        "Edit Phrase"
    }

    @Bindable var phrase: Phrase

    var content: some View {
        Form {
            TextEditor(text: phraseText)

        }
    }
    
    
    var phraseText : Binding<String> {
        Binding(
            get: { self.phrase.text },
            set: { self.phrase.text = $0 }
        )
    }
}
