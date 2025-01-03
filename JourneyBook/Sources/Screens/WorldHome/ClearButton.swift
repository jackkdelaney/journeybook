//
//  ClearButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI

struct ClearButton: View {
    @Binding var text: String

    @ViewBuilder
    var body: some View {
        if text.isEmpty == false {
            HStack {
                Spacer()
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .foregroundColor(.secondary)
            }
        }
    }
}
