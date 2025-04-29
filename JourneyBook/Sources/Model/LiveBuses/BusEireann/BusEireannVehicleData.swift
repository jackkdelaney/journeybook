//
//  BusEireannVehicleData.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/01/2025.
//

import CoreLocation

struct BusEireannVehicleData: Codable {
    let header: BusEireannHeader
    let entity: [BusEireannEntity]
}

struct BusEireannHeader: Codable {
    let gtfs_realtime_version: String
    let incrementality: String
    let timestamp: String
}

struct BusEireannEntity: Codable, Identifiable, RealTimeBusLocation{
    var VehicleIdentifier: String {
        vehicle.vehicle.id
    }
    
    
    var location: CLLocationCoordinate2D {
        .init(latitude: Double(vehicle.position.latitude), longitude: Double(vehicle.position.longitude))
    }
    
    var busOperator: BusOperator {
        BusOperator.getOperator(for: "BÉ")
    }
    
    let id: String
    let vehicle: BusEireannVehicle
}

struct BusEireannVehicle: Codable {
    let trip: BusEireannTrip
    let position: BusEireannPosition
    let timestamp: String
    let vehicle: BusEireannVehicleID
}

struct BusEireannTrip: Codable {
    let tripID: String
    let startTime: String
    let startDate: String
    let scheduleRelationship: String
    let routeID: String
    let directionID: Int


    enum CodingKeys: String, CodingKey {
            case tripID = "trip_id"
            case startTime = "start_time"
            case startDate = "start_date"
            case scheduleRelationship = "schedule_relationship"
            case routeID = "route_id"
            case directionID = "direction_id"
        }
}

extension BusEireannEntity : Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(VehicleIdentifier)
        hasher.combine(id)

    }
    
    static func ==(lhs: BusEireannEntity, rhs: BusEireannEntity) -> Bool {
        return lhs.id == rhs.id
    }
}

struct BusEireannPosition: Codable {
    let latitude: Double
    let longitude: Double
}

struct BusEireannVehicleID: Codable {
    let id: String
}
