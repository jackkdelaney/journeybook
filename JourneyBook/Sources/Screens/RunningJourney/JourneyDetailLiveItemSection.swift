//
//  JourneyDetailLiveItemSection.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 11/04/2025.
//

import SwiftUI



struct JourneyDetailLiveItemSection: View {
    @Bindable var journey: Journey

    @State private var model: LiveJourneyStepModel

    init(journey: Journey) {
        self.journey = journey
        model = LiveJourneyStepModel(journey: journey)
    }

    var body: some View {
        Section {
            Button {} label: {
                Text("Run this journey")
            }
        } footer: {
            Text("By running this journey, you can run the journey")
        }
    }
}
