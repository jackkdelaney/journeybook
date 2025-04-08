//
//  JourneyBookWidgetExtension.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 16/01/2025.
//

import WidgetKit
import SwiftUI
import Intents
import JourneyBook_shared

//@main
//struct DynamicIsland_WidgetBundle: WidgetBundle {
//    var body: some Widget {
////        DynamicIsland_Widget()
////        DynamicIsland_WidgetLiveActivity()
//        FastingActivityWidget()
//    }
//}
//

import WidgetKit
import SwiftUI

struct LiveActivityExpandedViewSample: View {
    var state: ActivityAttributesSample.ContentState
    var body: some View {
        VStack {
            Text ("Hello, CENTER")
            Text(state.value)
                .foregroundColor(.secondary)
        }
        .activityBackgroundTint(.gray)
    }
}

@main
struct LiveActivitySample: Widget {
    let kind: String = "LiveActivitySample"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ActivityAttributesSample.self) { context in
            LiveActivityExpandedViewSample(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    LiveActivityExpandedViewSample(state: context.state)
                }
                DynamicIslandExpandedRegion(.leading) {
                    Text("LEFT")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("RIGHT")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("BOTTOM")
                }
            } compactLeading: {
                Image(systemName: "capsule")
            } compactTrailing: {
                EmptyView()
            } minimal: {
                EmptyView()
            }

        }

    }
}

