//
//  JourneyStepDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI

struct JourneyStepDetailView: View {
    @EnvironmentObject private var coordinator: Coordinator

    @Bindable var step: JourneyStep

    var body: some View {
        Form {
            if let location = step.location {
                OpenInMapsButton(location: location)
            }
            Text("OTHER")
        }
        .safeAreaInset(edge: .top) {
            locationSection
        }
        .safeAreaInset(edge: .bottom) {
            if let stepDescription = step.stepDescription {
                Text(stepDescription)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    .background(
                        Rectangle()
                            .fill(.blue)
                            .overlay(.thinMaterial)
                    )
                    .ignoresSafeArea(edges: .bottom)
                    .ignoresSafeArea(edges: .bottom)
            }
        }
        .navigationTitle("\(step.stepName)")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var locationSection: some View {
        if let location = step.location {
            Button {
                coordinator.push(page: .mapDetails(location))
            } label: {
                MapInDetailView(location: location)
                    .ignoresSafeArea(edges: .top)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
            }
        } else {
            Text("No location added")
        }
    }
}
