//
//  JourneyBookLiveActivity.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 11/04/2025.
//

import SwiftUI
import WidgetKit
import CommonCodeKit
import AppExtensionJBKit


public struct JourneyBookLiveActivity: Widget {
    public let kind: String = "JourneyBookLiveActivity"

    public var body: some WidgetConfiguration {
        ActivityConfiguration(for: StepAttributes.self) { context in
            LiveActivityExpandedView(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    LiveActivityExpandedView(state: context.state)
                }
                DynamicIslandExpandedRegion(.leading) {
                    journeyBookLiveLogo
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.title)
                        .foregroundStyle(.purple)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Button {
                        } label: {
                            Text("Go to Next Step")
                        }
                        .tint(.purple)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                        Button {
                        } label: {
                            Text("End Journey")
                                
                        }
                        .tint(.purple)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    }
                }
            } compactLeading: {
                journeyBookLiveLogo
            } compactTrailing: {
                Text("\(context.state.stepNumber) of \(context.state.totalSteps)")
                    .foregroundStyle(.purple)
                    .fontWeight(.heavy)

            } minimal: {
                /*
                 SO IF LESS THAN 3 characters use the text otherwise, use the icon
                 */

                Text("1/2")
                    .foregroundStyle(.purple)
                    .fontWeight(.heavy)
            }
        }
    }
    
    
    private var journeyBookLiveLogo : some View {
        Label("Journey Book Current Journey", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
            .labelStyle(.iconOnly)
            .foregroundStyle(.purple)
            .fontWeight(.heavy)
    }
    
    public init() {}
}
