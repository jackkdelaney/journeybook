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
    
    private static var _activeCoordinator: Coordinator?
    
    public static var activeCoordinator: Coordinator? {
        return _activeCoordinator
    }
    
    init() {
        Coordinator._activeCoordinator = self
    }
    
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

extension Coordinator {
    static func start() -> Coordinator {
        if let _activeCoordinator {
            return _activeCoordinator
        } else {
            let cord = Coordinator()
            self._activeCoordinator  =  cord
            return cord
        }
    }
}


