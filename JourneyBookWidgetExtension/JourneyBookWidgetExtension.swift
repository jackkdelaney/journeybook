//
//  JourneyBookWidgetExtension.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 16/01/2025.
//

import WidgetKit
import SwiftUI
import Intents
import CommonCodeKit

@main
struct DynamicIsland_WidgetBundle: WidgetBundle {
    var body: some Widget {
//        DynamicIsland_Widget()
//        DynamicIsland_WidgetLiveActivity()
        //FastingActivityWidget()
        JourneyBookLiveActivity()
    }
}


import WidgetKit
import SwiftUI

struct LiveActivityExpandedViewSample: View {
    var state: ActivityAttributesSample.ContentState
    var body: some View {
        VStack {
            Text ("Expanded Content")
            Text(state.value)
                .foregroundColor(.secondary)
        }
        .activityBackgroundTint(.purple)
    }
}

struct JourneyBookLiveActivity: Widget {
    let kind: String = "JourneyBookLiveActivity"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ActivityAttributesSample.self) { context in
            LiveActivityExpandedViewSample(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    LiveActivityExpandedViewSample(state: context.state)
                }
                DynamicIslandExpandedRegion(.leading) {
                    Text("Journey Book")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Step 1/2")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Your Journey Button")
                }
            } compactLeading: {
                Label("Journey Book Current Journey", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                    .labelStyle(.iconOnly)
                    .foregroundStyle(.purple)
                    .fontWeight(.heavy)


            } compactTrailing: {
                Text("1 of 2")
                    .foregroundStyle(.purple)
                    .fontWeight(.heavy)

            } minimal: {
                /*
                 Ensure that your Live Activity is recognizable in the minimal presentation. If possible, display updated information instead of only presenting a logo, but ensure that people are able to quickly recognize your app. For example, the compact presentation for a Live Activity of the Timer app displays the remaining time instead of using a static icon.
                 
                 SO IF LESS THAN 3 characters use the text otherwise, use the icon
                 */
                
                Text("1/2")
                    .foregroundStyle(.purple)
                    .fontWeight(.heavy)

            }

        }

    }
}

