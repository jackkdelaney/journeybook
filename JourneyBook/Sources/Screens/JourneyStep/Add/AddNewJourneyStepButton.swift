//
//  AddNewJourneyStepButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import CoreLocation
import SwiftUI

struct AddNewJourneyStepButton: View {

    @Bindable var journey: Journey

    @Binding var sheet: JourneyStepSheet?

    var body: some View {
        Button {
            sheet = .addNewStep(journey)
        } label: {
            ZStack {
                Color.purple
                    .opacity(0.7)
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
    }
    
}
