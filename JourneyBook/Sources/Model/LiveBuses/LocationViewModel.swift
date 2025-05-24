//
//  LocationViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/01/2025.
//

import CoreLocation
import Foundation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        // Request the user to authorize accesing the location when in use
        locationManager.requestWhenInUseAuthorization()
        // Try to start updating location if already authorized
        locationManager.startUpdatingLocation()
    }

    func locationManager(
        _: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        // Update published variable with user location coordinates
        userLocation = location.coordinate
    }

    func locationManager(
        _: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            // If authorization status has changed to authorized
            // start updating location
            locationManager.startUpdatingLocation()
        }
    }
}
