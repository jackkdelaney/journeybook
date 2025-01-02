//
//  JourneyStepLocation.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import CoreLocation
import Foundation

struct JourneyStepLocation: Identifiable, Codable, Hashable {
    var id: UUID
    var latitude : Double
    var longitude : Double
    
    init(id: UUID = UUID(), location: CLLocationCoordinate2D) {
        self.id = id
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
    
    var location : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
