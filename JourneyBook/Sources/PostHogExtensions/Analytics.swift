//
//  Analytics.swift
//  AppExtensionJBKit
//
//  Created by Jack Delaney on 18/04/2025.
//

import PostHog

enum Analytics {
    case addNewJourney
    case deleteJourney
    case addNewJourneyStep
    case editJourney
    case deleteJourneyStep
    case editJourneyStep

    private var name: String {
        switch self {
            
        case .addNewJourney:
            return "Add New Journey"
            
        case .addNewJourneyStep:
            return  "Add New Journey Step"
            
        case .deleteJourney:
            return   "Delete Journey"
            
        case .editJourney:
            return   "Edit Journey"
            
        case .deleteJourneyStep:
            return  "Delete Journey Step"
            
        case .editJourneyStep:
            return   "Edit Journey Step"
            
            
        }
    }

    func capture() {
        PostHogSDK.shared.capture(name)
    }


}

