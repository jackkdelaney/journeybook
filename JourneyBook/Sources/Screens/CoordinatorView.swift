//
//  CoordinatorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            AppPages.resourceManager.build()
                .navigationDestination(for: AppPages.self) { page in
                    page.build()
                }
        }
        .environmentObject(coordinator)
    }
}
