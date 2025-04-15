//
//  SelectPhraseForConversationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SharedPersistenceKit
import SwiftData
import SwiftUI

struct SelectPhraseForConversationView: SheetView {
    @Binding var selectedPhrases: [Phrase]

    @Query var phrases: [Phrase]
    @Environment(\.dismiss) var dismiss

    @State private var searchText = ""
    @State private var searchIsActive = false

    @State var sheet: PhraseSheet? = nil

    var content: some View {
        List {
            Section(searchIsActive ? "Search Results" : "Phrases") {
                ForEach(filteredPhrsses) { phrase in
                    Button {
                        selectedPhrases.append(phrase)
                        dismiss()
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(phrase.text)")
                                    .font(.headline)
                                Text(phrase.dateCreated.formatted())
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                            }
                        }
                    }
                    .chevronButtonStyle()
                }
            }
        }
        .searchable(text: $searchText, isPresented: $searchIsActive)
        .overlay {
            if phrases.isEmpty {
                ContentUnavailableView(
                    "No Phrases",
                    systemImage: "waveform.slash"
                )
            } else if filteredPhrsses.isEmpty {
                ContentUnavailableView.search
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
    }

    var confirmButton: some View {
        Button {
            sheet = .addNewPhrase
        } label: {
            Label("Add New Phrase", systemImage: "plus")
        }
    }

    var sheetTitle: String {
        "Select Phrase"
    }

    private var filteredPhrsses: [Phrase] {
        if searchText.isEmpty {
            return phrases
        } else {
            return phrases.filter {
                $0.text.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
