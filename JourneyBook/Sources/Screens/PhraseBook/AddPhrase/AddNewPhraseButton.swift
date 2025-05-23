//
//  AddNewPhraseButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SwiftUI

struct AddNewPhraseButton: AnimatedBackGroundView {
    @Environment(\.accessibilityAssistiveAccessEnabled) var isAssistiveAccessEnabled

    @Binding var sheet: PhraseSheet?

    @State var animate = false

    var body: some View {
        Button {
            sheet = .addNewPhrase
        } label: {
            ZStack {
                meshGradient
                    .background(.ultraThickMaterial)

                HStack {
                    Image(systemName: "plus.circle.dashed")
                        .foregroundStyle(.thinMaterial)
                        .font(.largeTitle)
                    VStack {
                        Text("Add new Phrase")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text("Add New Phrase to Book")
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
    }

    var colours: [Color] { [
        .purple,
        .pink,
        .indigo,

        .pink.opacity(0.8),
        .purple.opacity(0.8),
        .indigo.opacity(0.8),

        .purple.opacity(0.5),
        .pink.opacity(0.6),
        .indigo.opacity(0.6),
    ]
    }

    var backgroundColor: Color {
        .black
    }
}
