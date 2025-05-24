//
//  JourneyStepLocationTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 17/04/2025.
//

import Foundation
import Testing

import CoreLocation
@testable import SharedPersistenceKit

struct JourneyStepLocationTests {
    @Test
    func initialisationSetsProperties() {
        let id = UUID()
        let location = CLLocationCoordinate2D(latitude: 0.0004, longitude: 0.0001)
        let model = JourneyStepLocation(id: id, location: location)

        #expect(model.id == id)
        #expect(model.latitude == location.latitude)
        #expect(model.longitude == location.longitude)
    }

    @Test
    func initialisationSetsPropertiesWithOwnID() {
        let id = UUID()
        let location = CLLocationCoordinate2D(latitude: 0.0004, longitude: 0.0001)
        let model = JourneyStepLocation(id: id, location: location)

        #expect(model.id == id)
        #expect(model.latitude == location.latitude)
        #expect(model.longitude == location.longitude)
    }

    @Test
    func locationComputedVar() {
        let location = CLLocationCoordinate2D(latitude: 0.0004, longitude: 0.0001)
        let model = JourneyStepLocation(location: location)

        #expect(model.location.latitude == location.latitude)
        #expect(model.location.longitude == location.longitude)
    }
}
