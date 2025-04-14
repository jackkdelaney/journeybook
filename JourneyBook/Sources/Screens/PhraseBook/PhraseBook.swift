//
//  PhraseBook.swift
//  JourneyBook
//
//  Created by Jack Delaney on 28/12/2024.

import SwiftUI

struct PhraseBook: View {
    @State private var sheet: PhraseSheet? = nil

    var body: some View {
        List {
            PersonalVoiceAuthorisationView()
            Section {
                AddNewPhraseButton(sheet: $sheet)
            }
            PhraseListView(sheet: $sheet)
        }
        .navigationTitle("Phrase Book")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    sheet = .voices

                } label: {
                    Label(
                        "Change Voice", systemImage: "person.line.dotted.person"
                    )
                }
                EditButton()
            }
        }
    }
}
