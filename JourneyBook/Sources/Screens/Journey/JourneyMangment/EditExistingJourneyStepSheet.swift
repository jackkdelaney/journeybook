//
//  EditExistingJourneyStepSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/03/2025.
//

import Foundation
import SwiftUI


/*
 AddNewJourneyStepView
 */


struct EditExistingJourneyStepSheet: SheetView {
    @Bindable var journeyStep: JourneyStep
    
    
    init(journeyStep: JourneyStep) {
        self.journeyStep = journeyStep
        
        
    }

    var sheetTitle: String {
        "Edit Step"
    }

    var content: some View {
        Form {
            Text("BOB")
        }
    }

    var confirmButton: some View {
        Button("Update") {
//            do {
//                if journeyName.isEmpty {
//                    throw JourneyViewModelError.noJourneyText
//                }
//                journey.journeyName = journeyName
//                journey.journeyDescription = journeyDescription
//                try modelContext.save()
//                dismiss()
//            } catch JourneyViewModelError.noJourneyText {
//                errorMessage = .noJourneyText
//            } catch {
//                print(error)
//            }
        }
    }
}
