//
//  ChevronButtonStyle.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

import SwiftUI

struct ChevronButtonStyle: ButtonStyle {
    let compact: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if compact {
                configuration.label
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.secondary)
            } else {
                configuration.label
                Spacer()

                Image(systemName: "chevron.forward")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .contentShape(Rectangle())
    }
}

extension View {
    func chevronButtonStyle(compact: Bool = false) -> some View {
        buttonStyle(ChevronButtonStyle(compact: compact))
    }

    func removeListRowPaddingInsets() -> some View {
        listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
