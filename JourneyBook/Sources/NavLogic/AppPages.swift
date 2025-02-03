//
//  AppPages.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI
import PostHog

enum AppPages: Hashable {
    case worldHome
    case resourceManager
    case resourceDetails(VisualResource)
    case gliderPOC
    case mapExperience
    case transportRoutes
    case phraseBook
    case journeyDetails(Journey)
    case journeyStepDetails(JourneyStep)
    case mapDetails(JourneyStepLocation)
    case rssFeedItem(RSSFeedItem)
    case webpage(URL)
    case credits
}


extension AppPages {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .resourceManager:
            ResourcesManager()
                .postHogScreenView()
        case let .resourceDetails(resource):
            ResourceView(resource: resource)
                .postHogScreenView()
        case .worldHome:
            WorldHome()
                .postHogScreenView()
        case .phraseBook:
            PhraseBook()
                .postHogScreenView()
        case .mapExperience:
            LiveBusMap()
                .postHogScreenView()
        case .gliderPOC:
            GliderPOCListView()
                .postHogScreenView()
        case .transportRoutes:
            TransportRouteListView()
                .postHogScreenView()
        case let .journeyDetails(journey):
            JourneyDetailView(journey: journey)
                .postHogScreenView()
        case let .journeyStepDetails(journeyStep):
            JourneyStepDetailView(step: journeyStep)
                .postHogScreenView()
        case let .mapDetails(location):
            MapDetailView(location: location)
                .postHogScreenView()
        case let .rssFeedItem(item):
            RSSFeedDetailView(item: item)
                .postHogScreenView()
        case let .webpage(theUrl):
            WebView(url: theUrl)
                .postHogScreenView()
        case .credits:
            CreditView()
                .postHogScreenView()
        }
    }
}
