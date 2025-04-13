//
//  CoordinatorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import PostHog
import SharedPersistenceKit
import SwiftData
import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator.start()

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
        .onOpenURL { url in
            // handle the in coming url or call a function
            handleURL(url: url)
        }
    }

    @Query private var journeys: [Journey]

    private func handleURL(url: URL) {
        switch url.host {
        case "journey":
            let possibleJourney = journeys.first(where: { $0.id.uuidString == url.pathComponents[1] })
            if let journey = possibleJourney {
                coordinator.popToRoot()
                coordinator.push(page: .journeyDetails(journey))

            } else {
                print("No Item exists with this ID")
            }
        default:
            break
        }
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
