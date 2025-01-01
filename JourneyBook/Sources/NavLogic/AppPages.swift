//
//  AppPages.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI

enum AppPages: Hashable {
    case worldHome
    case resourceManager
    case resourceDetails(VisualResource)
    case login
    case mapExperience
    case phraseBook
   // case addNewJourney
}

extension AppPages {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .resourceManager:
            ResourcesManager()
        case .login:
            Text("LOGIN")
        case let .resourceDetails(resource):
            ResourceView(resource: resource)
        case .worldHome:
            WorldHome()
        case .phraseBook:
            PhraseBook()
        case .mapExperience:
            MapView()
//        case .addNewJourney:
//            
        }
    }
}
