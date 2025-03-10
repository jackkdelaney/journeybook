//
//  AdvertButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/01/2025.
//

import SwiftUI

struct AdvertButton: View {
    @EnvironmentObject private var coordinator: Coordinator

    var title: String
    var tagLine: String
    var appPage: AppPages
    var symbol: String

    var body: some View {
        Section {
            HStack {
                Image(systemName: symbol)
                    .font(.largeTitle)
                    .padding()
                Spacer()
                VStack {
                    Text(tagLine)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("Select the Button Below")
                        .font(.caption2)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 100)
            .removeListRowPaddingInsets()
            .background(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.6), Color.purple.opacity(0.4)]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
            Button(title) {
                coordinator.push(page: appPage)
            }
            .chevronButtonStyle()
        }
    }
}
