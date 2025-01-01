//
//  JourneyDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 01/01/2025.
//

import SwiftUI

struct JourneyDetailView: View {

    var journey: Journey

    var body: some View {
        Form {
            if let description = journey.journeyDescription {
                Text(description)
            } else {
                Text("No Description")
            }
        }
        .navigationTitle(journey.journeyName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
