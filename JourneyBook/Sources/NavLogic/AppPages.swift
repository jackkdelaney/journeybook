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
    case gliderPOC
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
    case credits
    case acessblityHomeToolbarOptions
}

extension AppPages {
    var title : String {
        switch self {
        case .resourceManager:
            "Resources Mananger"
        case let .resourceDetails(resource):
            "Resources View"
        case .worldHome:
            "World Home"
        case .phraseBook:
            "Phrase Book"
        case .mapExperience:
           "Bus Map"
        case .gliderPOC:
            "Glider POC"
        case .transportRoutes:
            "Transport Routes"
        case let .journeyDetails(journey):
            "Journey Details"
        case let .journeyStepDetails(journeyStep):
            "Journey Step Details"
        case let .mapDetails(location):
            "Map Detail View"
        case let .rssFeedItem(item):
            "RSS Detail View"
        case let .webpage(theUrl):
            "Internal Web Broswer"
        case let .phraseDetails(phrase):
            "Phrase Detail View"
        case let .communicationDetail(communication):
            "Communiucation Details"
        case .credits:
            "Credits"
        case .communicationDirectory:
            "Communication"
        case .acessblityHomeToolbarOptions:
            "Acessblity"
        }
    }
}

extension AppPages {
    func build() -> some View {
        internalBuild()
        .postHogScreenView(self.title)
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
        case .gliderPOC:
            GliderPOCListView()
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
            WorldHomeAacessblityHomeToolbarOptions()
            
        }
    }
}
