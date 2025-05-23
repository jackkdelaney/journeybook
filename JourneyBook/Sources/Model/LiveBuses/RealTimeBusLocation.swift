//
//  RealTimeBusLocation.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/05/2025.
//

import CoreLocation
import Foundation

protocol RealTimeBusLocation: Identifiable, Decodable, Equatable {
    var id: String { get }
    var location: CLLocationCoordinate2D { get }
    var busOperator: BusOperator { get }
    var VehicleIdentifier: String { get }
    var busNumber: String { get }
}
