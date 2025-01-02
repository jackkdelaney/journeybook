//
//  AddNewJoruneyButtom.swift
//  JourneyBook
//
//  Created by Jack Delaney on 31/12/2024.
//

import SwiftUI

struct AddNewJoruneyButtom: View {
    @EnvironmentObject private var coordinator: Coordinator

    @Binding var sheet: JourneySheet?

    var body: some View {
        Button {
            sheet = .addNewJourney
        } label: {
            ZStack {
                Color.blue
                    .background(.ultraThickMaterial)

                HStack {
                    Image(systemName: "plus.circle.dashed")
                        .foregroundStyle(.thinMaterial)
                        .font(.largeTitle)
                    VStack {
                        Text("Create new Journey")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text("Click me to add a new Journey ")
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
}
