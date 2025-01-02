//
//  AddNewJourneyStepView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI
import CoreLocation

struct AddNewJourneyStepView: SheetView {
    
    
    @Environment(\.modelContext) var modelContext

    @Bindable var journey : Journey
    
    
    var content: some View {
        Button("Add New Phrase [Directly]"){
            let randomInt = Int.random(in: 1..<5)

            let location = JourneyStepLocation(location: CLLocationCoordinate2D(latitude: 54.597245, longitude: -5.930437))
            let step = JourneyStep(stepName: "Hello with Location!! \(randomInt)",journey: journey,location: location)
            modelContext.insert(step)
            order()
            try? modelContext.save()
        }
    }
    
    private func order() {
        let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
        for (index, item) in sortedLocalList.enumerated() {
            item.orderIndex = index
        }
    }
    
    var confirmButton: some View {
        Text("CONFIRM")
    }
    
    var sheetTitle: String {
        "Add New Step"
    }
}


