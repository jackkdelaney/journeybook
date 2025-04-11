//
//  JourneyStepLocation.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import CoreLocation
import Foundation

public struct JourneyStepLocation: Identifiable, Codable, Hashable {
    public var id: UUID
    public var latitude: Double
    public var longitude: Double

    public init(id: UUID = UUID(), location: CLLocationCoordinate2D) {
        self.id = id
        latitude = location.latitude
        longitude = location.longitude
    }

    public var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
