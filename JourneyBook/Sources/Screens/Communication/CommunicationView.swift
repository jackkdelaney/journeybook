//
//  CommunicationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

import SharedPersistenceKit
import SwiftData
import SwiftUI

struct CommunicationView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) private var editMode

    @Query var communictions: [Communication]

    @State private var sheet: CommunicationSheet? = nil

    var body: some View {
        List {
            if !communictions.isEmpty {
                ForEach(communictions) { communiction in
                    itemView(for: communiction)
                }
                .onDelete(perform: delete)
            }
        }
        .overlay {
            if communictions.isEmpty {
                ContentUnavailableView {
                    Label("No Communications", systemImage: "archivebox.fill")
                } description: {
                    Text("Communications that you add will appear here.")
                }
            }
        }
        .navigationTitle("Communication")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    sheet = .addNewCommunication
                } label: {
                    Label("Add Communication", systemImage: "plus")
                }
                .disabled(disableAddButton)
                EditButton()
                    .disabled(disableEditButton)
            }
        }
    }

    private var disableAddButton: Bool {
        if let editMode = editMode {
            return editMode.wrappedValue.isEditing
        }
        return false
    }

    private var disableEditButton: Bool {
        if let editMode = editMode {
            return !editMode.wrappedValue.isEditing && communictions.isEmpty
        }
        return communictions.isEmpty
    }

    private func itemView(for communication: Communication) -> some View {
        Button {
            coordinator.push(page: .communicationDetail(communication))
        } label: {
            VStack {
                Text(communication.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(communication.communictionType.stringName)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .chevronButtonStyle()
    }

    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            let communication = communictions[offset]
            for step in communication.steps {
                modelContext.delete(step)
            }
            modelContext.delete(communication)
        }
        do {
            try modelContext.save()
        } catch {}
    }
}
