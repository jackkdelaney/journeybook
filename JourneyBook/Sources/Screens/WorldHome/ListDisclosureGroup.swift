//
//  ListDisclosureGroup.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/01/2025.
//

import SwiftUI

struct ListDisclosureGroup<InsideView: View>: View {
    var title: String
    var contentView: () -> InsideView
    @State var isExpanded: Bool
    @State private var rotating = false

    init(_ title: String, openAtStart startingPoint: Bool = false, @ViewBuilder _ content: @escaping () -> InsideView) {
        self.title = title
        self._isExpanded = State(initialValue: startingPoint)
        contentView = content
    }

    var body: some View {
        Section {
            if isExpanded {
                contentView()
            }
        } header: {
            Button {
                isExpanded.toggle()

            } label: {
                HStack {
                    Text(title)
                    Spacer()
                    Image(
                        systemName: isExpanded
                            ? "chevron.down" : "chevron.right")
                }
                .padding(.bottom, 12)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}
