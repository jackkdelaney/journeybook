//
//  CoordinatorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()

    @Namespace var namespace

    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            AppPages.worldHome.build()
                .navigationDestination(for: AppPages.self) { page in
                    page.build()
                     //   .navigationTransition(.zoom(sourceID: page.hashValue, in: namespace))

                }
        }
        .environmentObject(coordinator)
    }
}
