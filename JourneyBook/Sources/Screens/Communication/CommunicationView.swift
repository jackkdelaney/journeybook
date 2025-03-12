//
//  CommunicationView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

import SwiftData
import SwiftUI

struct CommunicationView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.editMode) private var editMode

    @State private var sheet: CommunicationSheet? = nil

    @Query var communictions: [Communiction]

    var body: some View {
        List {
            if !communictions.isEmpty {
                ForEach(communictions) { communiction in
                    itemView(for: communiction)
                }
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
                EditButton()
                    .disabled(disableEditButton)
            }
        }
    }

    private var disableEditButton: Bool {
        if let editMode = editMode {
            return !editMode.wrappedValue.isEditing && communictions.isEmpty
        }
        return communictions.isEmpty
    }

    private func itemView(for communication: Communiction) -> some View {
        Button {
            coordinator.push(page: .communicationDetail(communication))
        } label: {
            VStack {
                Text(communication.title)
                Text(communication.communictionType.stringName)
                    .font(.caption)
            }
        }
        .chevronButtonStyle()
    }
}
