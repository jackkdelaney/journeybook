//
//  AddJourneyStepSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI
import CoreLocation

struct AddJourneyLocationStepGetter: Identifiable,Hashable,Equatable {
    var id: UUID
    
    var location : Binding<CLLocationCoordinate2D?>
    
    init(id: UUID = UUID(), location: Binding<CLLocationCoordinate2D?>) {
        self.id = id
        self.location = location
    }
    
    static func == (lhs: AddJourneyLocationStepGetter, rhs: AddJourneyLocationStepGetter) -> Bool {
           lhs.id == rhs.id
       }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum AddJourneyStepSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case getLocationFromAddress(AddJourneyLocationStepGetter)
}

extension AddJourneyStepSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .getLocationFromAddress(locationGetter):
            LocationFindView(selectedLocation:locationGetter.location)
        }
    }
}


