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
            Text ("Expanded Content")
            Text(state.value)
                .foregroundColor(.secondary)
        }
        .activityBackgroundTint(.purple)
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
                    Text("Journey Book")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Step 1/2")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Your Journey Button")
                }
            } compactLeading: {
                Image(systemName: "book.closed.circle")

//                HStack {
//                    Image(systemName: "j.square.fill")
//                    Image(systemName: "b.square.fill")
//                }
            } compactTrailing: {
                Image("journeyBookIcon")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)

            } minimal: {
                Text("J.B")

            }

        }

    }
}

