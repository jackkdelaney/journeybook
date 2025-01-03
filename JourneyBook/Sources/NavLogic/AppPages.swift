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
    case mapExperience
    case phraseBook
    case journeyDetails(Journey)
    case journeyStepDetails(JourneyStep)
    case mapDetails(JourneyStepLocation)
}

extension AppPages {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .resourceManager:
            ResourcesManager()
        case let .resourceDetails(resource):
            ResourceView(resource: resource)
        case .worldHome:
            WorldHome()
        case .phraseBook:
            PhraseBook()
        case .mapExperience:
            MapView()
        case let .journeyDetails(journey):
            JourneyDetailView(journey: journey)
        case let .journeyStepDetails(journeyStep):
            JourneyStepDetailView(step: journeyStep)
        case let .mapDetails(location):
            MapDetailView(location: location)
        }
    }
}
