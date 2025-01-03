//
//  AddJourneyStepSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import CoreLocation
import SwiftUI

struct AddJourneyLocationStepGetter: Identifiable, Hashable, Equatable {
    var id: UUID

    var location: Binding<CLLocationCoordinate2D?>

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

struct AddJourneyLocationVisualResourceGetter: Identifiable, Hashable, Equatable {
    var id: UUID

    var resource: Binding<VisualResource?>

    init(id: UUID = UUID(), resource: Binding<VisualResource?>) {
        self.id = id
        self.resource = resource
    }

    static func == (lhs: AddJourneyLocationVisualResourceGetter, rhs: AddJourneyLocationVisualResourceGetter) -> Bool {
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
    case getVisualResourceFromList(AddJourneyLocationVisualResourceGetter)
    
}

extension AddJourneyStepSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .getLocationFromAddress(locationGetter):
            LocationFindView(selectedLocation: locationGetter.location)
        case let .getVisualResourceFromList(resourceGetter):
            ResourceSelectionView(selection: resourceGetter.resource)
        }
    }
}
