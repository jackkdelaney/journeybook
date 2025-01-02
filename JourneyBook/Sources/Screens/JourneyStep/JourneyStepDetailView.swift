//
//  JourneyStepDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI

struct JourneyStepDetailView: View {
    
    @Bindable var step: JourneyStep
    
    
    var body: some View {
        Form {
            Text("Hello, World!")
        }
        .navigationTitle("\(step.stepName)")
            .navigationBarTitleDisplayMode(.inline)
    }
}


