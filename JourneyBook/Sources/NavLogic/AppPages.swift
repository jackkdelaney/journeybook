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
    case communicationDetail(Communiction)
    case credits
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
        }
    }
}

/* // MARK: POST HOG IDEAS
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

 */
