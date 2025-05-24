//
//  PhraseListView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SharedPersistenceKit
import SwiftData
import SwiftUI

struct PhraseListView: View {
    @Query var phrases: [Phrase]

    @Environment(\.modelContext) var modelContext
    @EnvironmentObject private var coordinator: Coordinator

    @Binding var sheet: PhraseSheet?

    @ViewBuilder
    var body: some View {
        if !phrases.isEmpty {
            ListDisclosureGroup(
                "Phrases's",
                footer: "Click down on the Phrase to edit its text and colour."
            ) {
                ForEach(phrases) { phrase in
                    Button {
                        coordinator.push(page: .phraseDetails(phrase))

                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(phrase.text)")
                                    .font(.headline)
                                    .lineLimit(2)
                                Text(phrase.dateCreated.formatted())
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                                    .frame(
                                        maxWidth: .infinity, alignment: .leading
                                    )
                            }
                        }
                    }
                    .chevronButtonStyle(compact: true)
                    .contextMenu {
                        Button(role: .destructive) {
                            deletePhrase(phrase: phrase)
                        } label: {
                            Label("Delete Phrase", systemImage: "trash")
                        }
                        Button {
                            sheet = .editPhrase(phrase)
                        } label: {
                            Label("Edit Phrase", systemImage: "pencil")
                        }
                    }
                }
                .onDelete(perform: delete)
            }
        }
    }

    private func deletePhrase(phrase: Phrase) {
        for phraseStep in phrase.steps {
            phraseStep.phrases.removeAll { $0.id == phrase.id }
        }
        modelContext.delete(phrase)

        do {
            try modelContext.save()
        } catch {}
    }

    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            let phrase = phrases[offset]
            for phraseStep in phrase.steps {
                phraseStep.phrases.removeAll { $0.id == phrase.id }
            }
            modelContext.delete(phrase)
        }
        do {
            try modelContext.save()
        } catch {}
    }
}
