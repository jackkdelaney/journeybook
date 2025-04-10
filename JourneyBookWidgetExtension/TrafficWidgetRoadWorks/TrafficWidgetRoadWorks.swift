//
//  TrafficWidgetRoadWorks.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 10/04/2025.
//

import SwiftUI
import WidgetKit

struct TrafficWidgetRoadWorks: Widget {
    // 3.
    let kind: String = "JourneyBook-Roadworks-NI"
    var body: some WidgetConfiguration {
        // 4.
        StaticConfiguration(
            kind: kind,
            provider: TrafficIncidentsProvider()
        ) { entry in
            TrafficWatchWidgetView(entry: entry)
        }
        // 5.
        .configurationDisplayName("Northern Ireland Roadworks")
        // 6.
        .description("Northern Ireland Roadworks traffic updates")
        // 7.
        .supportedFamilies([
            .systemMedium,
            .systemLarge,
        ])
    }
}
