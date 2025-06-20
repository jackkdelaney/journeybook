//
//  AddNewJourneyStepButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import CoreLocation
import SharedPersistenceKit
import SwiftUI

struct AddNewJourneyStepButton: AnimatedBackGroundView {
    @Environment(\.accessibilityAssistiveAccessEnabled) var isAssistiveAccessEnabled

    @Bindable var journey: Journey

    @Binding var sheet: JourneyStepSheet?

    var body: some View {
        Button {
            sheet = .addNewStep(journey)
        } label: {
            ZStack {
                meshGradient
                    .background(.thickMaterial)

                HStack {
                    Image(systemName: "plus.square.dashed")
                        .foregroundStyle(.thinMaterial)
                        .tint(.pink)
                        .font(.largeTitle)
                    VStack {
                        Text("Add New Step")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .foregroundStyle(.ultraThickMaterial)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            }
        }
        .contentShape(Rectangle())
        .removeListRowPaddingInsets()
        .buttonStyle(PlainButtonStyle())
        .accessibilityIdentifier(
            "AddNewStepButton"
        )
    }

    var colours: [Color] { [
        .purple.opacity(0.9),
        .purple.opacity(0.9),
        .purple.opacity(0.9),
        .pink.opacity(0.8),
        .pink.opacity(0.7),
        .purple.opacity(0.7),
        .purple.opacity(0.6),
    ]
    }

    var backgroundColor: Color {
        .purple
    }
}
