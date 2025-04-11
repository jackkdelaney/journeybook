//
//  JourneyBookLiveActivity.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 11/04/2025.
//

import SwiftUI
import WidgetKit
import CommonCodeKit

struct JourneyBookLiveActivity: Widget {
    let kind: String = "JourneyBookLiveActivity"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StepAttributes.self) { context in
            LiveActivityExpandedView(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    LiveActivityExpandedView(state: context.state)
                }
                DynamicIslandExpandedRegion(.leading) {
                    Text("Journey Book")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Step \(context.state.stepNumber)/\(context.state.totalSteps)")
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
                Text("\(context.state.stepNumber) of \(context.state.totalSteps)")
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
