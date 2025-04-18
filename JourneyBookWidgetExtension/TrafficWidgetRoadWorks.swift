//
//  TrafficWidgetRoadWorks.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 10/04/2025.
//

import SwiftUI
import WidgetKit
import AppExtensionJBKit

struct TrafficWidgetRoadWorks: Widget {
    let kind: String = "JourneyBook-Roadworks-NI"
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: TrafficIncidentsProvider()
        ) { entry in
            TrafficWatchWidgetView(entry: entry)
        }
        .configurationDisplayName("Northern Ireland Roadworks")
        .description("Northern Ireland Roadworks traffic updates")
        .supportedFamilies([
            .systemMedium,
            .systemLarge,
        ])
    }
}
