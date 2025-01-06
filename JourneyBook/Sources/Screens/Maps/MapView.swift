//
//  MapView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import MapKit
import SwiftUI

// VERY GOOD GUIDE
// https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 54.5973, longitude: -5.9301),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    var locations = BusLocations.load(from: "november-cords").prefix(499)

    @ObservedObject var locationViewModel = LocationViewModel()

    var body: some View {
        VStack {
            Map(position: .constant(.region(region))) {
                ForEach(locations) { location in
                    Annotation(location.commonName, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        Image(systemName: "bus")
                    }
                }
            }
            if let location = locationViewModel.userLocation {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            } else {
                Text("Location not available.")
            }
        }
    }
}

import CoreLocation

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

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Update published variable with user location coordinates
        userLocation = location.coordinate
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            // If authorization status has changed to authorized
            // start updating location
            locationManager.startUpdatingLocation()
        }
    }
}
