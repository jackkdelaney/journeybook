//
//  HomeTips.swift
//  JourneyBook
//
//  Created by Jack Delaney on 28/04/2025.
//

import SwiftUI
import TipKit

enum HomeTips: Tip {
    case add
    case addStep
    case editJourneyDesc

    
    var title: Text {
        switch self {
        case .add:
            Text("Add a new Journey.")
        case .addStep:
            Text("Add a New Step")
        case .editJourneyDesc:
            Text("Edit Journey Descirpiton")
        }
    }
}
