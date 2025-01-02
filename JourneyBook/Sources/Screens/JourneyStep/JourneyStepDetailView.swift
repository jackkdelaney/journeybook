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
            Section() {
                Button {
                                                    UIApplication.shared.open(appleUrl!, options: [:], completionHandler: nil)
                                                } label: {
                                                    Label("Open in Apple Maps",systemImage: "map")
                                                }
                                          
            }
          
        }
        .safeAreaInset(edge: .top) {
                         locationSection
                     
                 }
        .navigationTitle("\(step.stepName)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    @ViewBuilder
    private var locationSection: some View {
        if let location = step.location {
            Button {
                coordinator.push(page: .mapDetails(location))
            }label: {
                MapInDetailView(location: location)
                    .ignoresSafeArea(edges: .top)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
            }
        } else {
            Text("No location added")
        }
    }
    
    private var canOpenAppleMaps : Bool {
        UIApplication.shared.canOpenURL(appleUrl!)
    }
    private var appleUrl : URL? {
        if let location = step.location {
            URL(string: "maps://?saddr=&daddr=\(location.latitude),\(location.longitude)")
        } else {
            nil
        }
    }
}
