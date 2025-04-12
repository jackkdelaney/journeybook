//
//  MapInDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import MapKit
import SwiftUI
import SharedPersistenceKit

struct MapInDetailView: View {
    @State private var postion: MapCameraPosition

    private let location: JourneyStepLocation
    private let locked: Bool

    init(location: JourneyStepLocation, locked: Bool = true) {
        self.locked = locked
        _postion = State(initialValue: MapCameraPosition.region(MKCoordinateRegion(
            center: location.location,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )))
        self.location = location
    }

    var body: some View {
        ZStack {
            Map(position: $postion, interactionModes: interactionModes) {
                Marker("Location", coordinate: location.location)
            }
            .mapStyle(.standard(elevation: .realistic))
        }
    }

    var interactionModes: MapInteractionModes {
        if locked {
            return []
        } else {
            return .all
        }
    }
}

// MARK: THIS VIEW CAN BE GENERZLISED AND USED BETWEEN
