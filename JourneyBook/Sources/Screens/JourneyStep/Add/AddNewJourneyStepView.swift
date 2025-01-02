//
//  AddNewJourneyStepView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI
import CoreLocation

struct AddNewJourneyStepView: SheetView {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Bindable var journey : Journey
    
    @State private var localName : String = ""
    @State private var localDescription : String = ""
        
    @State private  var sheet : AddJourneyStepSheet?
    
    @State private var cordinates : CLLocationCoordinate2D?

    
    var locationSection : some View {
        Section("Location") {
            if let cordinates {
                MapInDetailView(location: JourneyStepLocation(location: cordinates ) )
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .removeListRowPaddingInsets()
            } else {
                Button("Find Location") {
                    let locationWrapped = AddJourneyLocationStepGetter(location: $cordinates)
                    sheet = .getLocationFromAddress(locationWrapped)
                }

            }
        }
    }
    var content: some View {
        Form {
            Section("Step Name") {
                TextField("Step Name", text: $localName)

            }
            Section("Description") {
                TextEditor(text: $localDescription)
            }
            locationSection
            
            
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
    }
    
  
 
    
    var confirmButton: some View {
        Button("Save") {
            add()
            dismiss()
        }
        .disabled(localName.isEmpty)
    }
    
    var sheetTitle: String {
        "Add New Step"
    }
    
    private func order() {
        let sortedLocalList = journey.steps.sorted(by: { $0.orderIndex < $1.orderIndex })
        for (index, item) in sortedLocalList.enumerated() {
            item.orderIndex = index
        }
    }
    
    
    private func add() {
        let desc = localDescription.isEmpty ? nil : localDescription
        let location : JourneyStepLocation?
        if let cordinates {
            location = JourneyStepLocation(location: CLLocationCoordinate2D(latitude: cordinates.latitude, longitude: cordinates.longitude))
        } else {
            location = nil
        }
     
        let step = JourneyStep(
            stepName: localName,
            stepDescription:desc,
            journey: journey,
            location: location
            )
            modelContext.insert(step)
            order()
            try? modelContext.save()
        }
}




