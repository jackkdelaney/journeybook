//
//  AppPages.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI

enum AppPages: Hashable {
    case resourceManager
    case resourceDetails(VisualResource)
    case login
}

extension AppPages {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .resourceManager: ResourcesManager()
        case .login:
            Text("LOGIN")
        case .resourceDetails(let resource):
            ResourceView(resource: resource)
        }
    }
    
}
