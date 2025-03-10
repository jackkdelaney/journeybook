//
//  CoordinatorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import PostHog
import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()

    @Namespace var namespace

    init() {
        loadEnvironmentVariables()
    }

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

    private func loadEnvironmentVariables() {
        if let path = Bundle.main.path(forResource: ".env", ofType: nil) {
            let contents = try? String(contentsOfFile: path, encoding: .utf8)
            contents?.split(separator: "\n").forEach { line in
                let keyValue = line.split(separator: "=", maxSplits: 1)
                if keyValue.count == 2 {
                    setenv(String(keyValue[0]), String(keyValue[1]), 1)
                }
            }
        }
    }
}
