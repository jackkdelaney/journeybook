//
//  WorldHome.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI

struct WorldHome: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        List {
            Button("MAP EXPERIENCE") {
                coordinator.push(page: .mapExperience)
            }

        }
        .navigationTitle("JourneyBook")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button {
                        coordinator.push(page: .resourceManager)
                    } label: {
                        Label("Resource Manager", systemImage: "house.lodge")
                    }
                } label: {
                    Label("Options", systemImage: "case")
                }
            }
            
        }


    }
    
}
