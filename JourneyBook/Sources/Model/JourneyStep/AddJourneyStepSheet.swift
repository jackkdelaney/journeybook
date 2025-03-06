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

    var resources: Binding<[VisualResource]>

    init(id: UUID = UUID(), resources: Binding<[VisualResource]>) {
        self.id = id
        self.resources = resources
    }

    static func == (lhs: AddJourneyLocationVisualResourceGetter, rhs: AddJourneyLocationVisualResourceGetter) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct AddJourneyPhraseSelectionGetter: Identifiable, Hashable, Equatable {
    var id: UUID
    var phrases: Binding<[Phrase]>

    init(id: UUID = UUID(), phrases: Binding<[Phrase]>) {
        self.id = id
        self.phrases = phrases
    }

    static func == (lhs: AddJourneyPhraseSelectionGetter, rhs: AddJourneyPhraseSelectionGetter) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct AddJourneyTransportGetter: Identifiable, Hashable, Equatable {
    var id: UUID

    var transport: Binding<TransportRoute?>

    init(id: UUID = UUID(), transport: Binding<TransportRoute?>) {
        self.id = id
        self.transport = transport
    }

    static func == (lhs: AddJourneyTransportGetter, rhs: AddJourneyTransportGetter) -> Bool {
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
    case getTransportRouteFromList(AddJourneyTransportGetter)
    case selectPhrases(AddJourneyPhraseSelectionGetter)
}

extension AddJourneyStepSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .getLocationFromAddress(locationGetter):
            LocationFindView(selectedLocation: locationGetter.location)
        case let .getVisualResourceFromList(resourceGetter):
            ResourceSelectionView(selectedResources: resourceGetter.resources)
        case let .getTransportRouteFromList(transportGetter):
            TransportRouteSelectorView(selectedRoute: transportGetter.transport)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.automatic)
        case let .selectPhrases(wrapper):
            PhrasesSelectorView(phrases: wrapper.phrases)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.automatic)
        }
    }
}
