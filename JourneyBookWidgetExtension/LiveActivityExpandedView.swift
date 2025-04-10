//
//  LiveActivityExpandedView.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 11/04/2025.
//

import WidgetKit
import SwiftUI
import CommonCodeKit

struct LiveActivityExpandedView: View {
    var state: StepAttributes.ContentState
    var body: some View {
        VStack {
            Text ("Expanded Content")
            Text("\(state.stepNumber) of \(state.totalSteps)")
                .foregroundColor(.secondary)
        }
        .activityBackgroundTint(.purple)
    }
}
