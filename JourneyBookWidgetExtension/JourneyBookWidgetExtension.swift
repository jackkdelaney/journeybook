//
//  JourneyBookWidgetExtension.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 16/01/2025.
//

import Intents
import SwiftUI
import WidgetKit

@main
struct JourneyBookWidgetExtensionWidgetBundle: WidgetBundle {
    var body: some Widget {
        JourneyBookLiveActivity()
        PossibleJourneyWidget()
    }
}
