//
//  LiveActivityExpandedView.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 11/04/2025.
//

import CommonCodeKit
import SwiftUI
import WidgetKit

public struct LiveActivityExpandedView: View {
    public var state: StepAttributes.ContentState
    public var body: some View {
        VStack {
            Text("This gives more detials")
            Text("\(state.stepNumber) of \(state.totalSteps)")
                .foregroundColor(.secondary)
        }
        .activityBackgroundTint(.purple)
    }
    
   public init(state: StepAttributes.ContentState) {
        self.state = state
    }
}
