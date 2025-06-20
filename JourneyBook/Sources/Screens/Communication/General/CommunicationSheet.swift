//
//  CommunicationSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SharedPersistenceKit
import SwiftUI

enum CommunicationSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case addNewCommunication
    case editCommunication(Communication)
}

extension CommunicationSheet {
    @MainActor @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addNewCommunication: AddNewCommunicationView()
        case let .editCommunication(communication):
            CommunicationDetailView(communication: communication, inSheet: true)
        }
    }
}
