//
//  AppPages.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import CommonCodeKit
import SharedPersistenceKit
import SwiftUI

enum AppPages: Hashable {
    case worldHome
    case resourceManager
    case resourceDetails(VisualResource)
    case mapExperience
    case transportRoutes
    case phraseBook
    case communicationDirectory
    case journeyDetails(Journey)
    case journeyStepDetails(JourneyStep)
    case mapDetails(JourneyStepLocation)
    case rssFeedItem(RSSFeedItem)
    case webpage(URL)
    case phraseDetails(Phrase)
    case communicationDetail(Communication)
    case locationBusDetailTranslink(TranslinkRealTimeBusLocation)
    case locationBusDetailBE(BusEireannEntity)
    case credits
    case acessblityHomeToolbarOptions
}

extension AppPages {
    var title: String {
        switch self {
        case .resourceManager:
            "Resources Mananger"
        case .resourceDetails:
            "Resources View"
        case .worldHome:
            "World Home"
        case .phraseBook:
            "Phrase Book"
        case .mapExperience:
            "Bus Map"
        case .transportRoutes:
            "Transport Routes"
        case .journeyDetails:
            "Journey Details"
        case .journeyStepDetails:
            "Journey Step Details"
        case .mapDetails:
            "Map Detail View"
        case .rssFeedItem:
            "RSS Detail View"
        case .webpage:
            "Internal Web Broswer"
        case .phraseDetails:
            "Phrase Detail View"
        case .communicationDetail:
            "Communiucation Details"
        case .credits:
            "Credits"
        case .communicationDirectory:
            "Communication"
        case .acessblityHomeToolbarOptions:
            "Acessblity"
        case .locationBusDetailTranslink, .locationBusDetailBE:
            "Bus Location Details"
        }
    }
}

extension AppPages {
    func build() -> some View {
        internalBuild()
    }

    @ViewBuilder
    private func internalBuild() -> some View {
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
            LiveBusMap()
        case .transportRoutes:
            TransportRouteListView()
        case let .journeyDetails(journey):
            JourneyDetailView(journey: journey)
        case let .journeyStepDetails(journeyStep):
            JourneyStepDetailView(step: journeyStep)
        case let .mapDetails(location):
            MapDetailView(location: location)
        case let .rssFeedItem(item):
            RSSFeedDetailView(item: item)
        case let .webpage(theUrl):
            WebView(url: theUrl)
        case let .phraseDetails(phrase):
            PhraseDetailView(phrase: phrase)
        case let .communicationDetail(communication):
            CommunicationDetailView(communication: communication, inSheet: false)
        case .credits:
            CreditView()
        case .communicationDirectory:
            CommunicationView()
        case .acessblityHomeToolbarOptions:
            WorldHomeAccessibilityHomeToolbarOptions()
        case let .locationBusDetailBE(busLocaton):
            LiveBusMapDetailView(location: busLocaton)
        case let .locationBusDetailTranslink(busLocaton):
            LiveBusMapDetailView(location: busLocaton)
        }
    }
}
