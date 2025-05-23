//
//  WorldHomeAccessibilityHomeToolbarOptions.swift
//  JourneyBook
//
//  Created by Jack Delaney on 19/03/2025.
//

import SwiftUI

struct WorldHomeAccessibilityHomeToolbarOptions: View {
    var body: some View {
        Form {
                WorldHomeNavigationButtons()
                        .chevronButtonStyle()
        }
        .navigationTitle("Options")
        .navigationBarTitleDisplayMode(.inline)
    }
}
