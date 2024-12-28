//
//  Coordinator.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import Foundation
import SwiftUI

// BASED UPON https://www.swiftanytime.com/blog/coordinator-pattern-in-swiftui

class Coordinator: ObservableObject {
    @Published var path: NavigationPath = .init()

    func push(page: AppPages) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
