//
//  CommunicationSelectorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 14/03/2025.
//

import SwiftData
import SwiftUI
import SharedPersistenceKit

struct CommunicationSelectorView: View {
    @Query var communications: [Communication]

    @Binding var selectedCommunication: Communication?

    var body: some View {
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
    }
}
