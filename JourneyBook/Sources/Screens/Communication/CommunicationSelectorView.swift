//
//  CommunicationSelectorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 14/03/2025.
//

import SharedPersistenceKit
import SwiftData
import SwiftUI

struct CommunicationSelectorView: SheetView {
    @Query var communications: [Communication]

    @Binding var selectedCommunication: Communication?

    @State private var sheet: CommunicationSheet? = nil

    var content: some View {
        List {
            ForEach(communications) { communication in
                HStack {
                    Button {
                        selectedCommunication = communication
                    } label: {
                        HStack {
                            Text(communication.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            if selectedCommunication == communication {
                                Label("Item Selected", systemImage: "checkmark")
                                    .labelStyle(.iconOnly)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .overlay {
            if communications.isEmpty {
                ContentUnavailableView(
                    "No Communication",
                    systemImage: "engine.combustion.badge.exclamationmark"
                )
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
    }

    var confirmButton: some View {
        Button {
            sheet = .addNewCommunication
        } label: {
            Label("Add Communication", systemImage: "plus")
        }
    }

    var sheetTitle: String {
        "Select Communication"
    }
}
