//
//  AnnotationItem.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import CoreLocation


struct AnnotationItem: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
