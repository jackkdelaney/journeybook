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
            if model.journeyNotLive {
                Button {
                    model.makeNewLiveJourney()
                } label: {
                    Text("Run this journey")
                }
            }
        } footer: {
            Text("CUSTOM TEXT!!!")
        }
    }
    
    
}
