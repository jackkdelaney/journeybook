//
//  ListDisclosiureGroup.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/01/2025.
//

import SwiftUI

struct ListDisclosiureGroup<InsideView: View>: View {
    var title: String
    var contentView: () -> InsideView
    @State var isExpanded: Bool = false
    @State private var rotating = false

    init(_ title: String, @ViewBuilder _ content: @escaping () -> InsideView)
    {
        self.title = title
        self.contentView = content
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

