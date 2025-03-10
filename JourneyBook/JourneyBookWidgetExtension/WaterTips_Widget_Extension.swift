//
//  WaterTips_Widget_Extension.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 16/01/2025.
//

import SwiftUI

// 1.
import WidgetKit

// 2.
@main
struct JourneyBookWidgetExtension: Widget {
    // 3.
    let kind: String = "Create-With-Swift-Example_Widget"
    var body: some WidgetConfiguration {
        // 4.
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            TrafficWatchWidgetView(entry: entry)
        }
        // 5.
        .configurationDisplayName("Post Data Widget")
        // 6.
        .description("Displays data from an API.")
        // 7.
        .supportedFamilies([
            .systemMedium,
            .systemLarge,
        ])
    }
}

// #Preview(as: .systemMedium) {
//    JourneyBookWidgetExtension()
// } timeline: {
//    WaterEntry(date: .now, waterTip: "Drink water!")
//    WaterEntry(date: .now + 1, waterTip: "Did you drink water?")
// }
//
// #Preview(as: .systemLarge) {
//    JourneyBookWidgetExtension()
// } timeline: {
//    WaterEntry(date: .now, waterTip: "Drink water!")
//    WaterEntry(date: .now + 1, waterTip: "Did you drink water?")
// }
