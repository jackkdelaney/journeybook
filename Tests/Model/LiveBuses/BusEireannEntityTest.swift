//
//  BusEireannEntityTest.swift
//  SharedPersistenceKit
//
//  Created by Jack Delaney on 16/04/2025.
//

import CoreLocation
import Testing

@testable import JourneyBook

struct BusEireannEntityTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let item = BusEireannEntity(id: "33", vehicle: testBus())

        #expect(item.id == "33")
        #expect(item.vehicle.vehicle.id == testBus().vehicle.id)
    }

    @Test
    func testVehicleIdentifier() {
        let item = BusEireannEntity(id: "33", vehicle: testBus())

        #expect(item.VehicleIdentifier == "3")
    }

    @Test
    func testLocation() {
        let item = BusEireannEntity(id: "33", vehicle: testBus())

        #expect(item.location.latitude == CLLocationCoordinate2D(latitude: 10, longitude: -10).latitude)
        #expect(item.location.longitude == CLLocationCoordinate2D(latitude: 10, longitude: -10).longitude)
    }

    @Test
    func busOperator() {
        let item = BusEireannEntity(id: "33", vehicle: testBus())

        #expect(item.busOperator == BusOperator.getOperator(for: "BÉ"))
    }

    private func testBus() -> BusEireannVehicle {
        BusEireannVehicle(trip: BusEireannTrip(tripID: "33", startTime: "2222", startDate: "2222", scheduleRelationship: "", routeID: "", directionID: 2), position: BusEireannPosition(latitude: 10, longitude: -10), timestamp: "", vehicle: BusEireannVehicleID(id: "3"))
    }
}
