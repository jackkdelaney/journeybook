//
//  MapView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI
import MapKit

// VERY GOOD GUIDE
//https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui



struct BusLocations : Identifiable {
    var id: String
    var atcoCode: String
    var commonName : String
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var easting : String
    var northing : String
    
    init(id: String, atcoCode: String, commonName: String, latitude: String, longitude: String, easting: String, northing: String) {
        self.id = id
        self.atcoCode = atcoCode
        self.commonName = commonName
        self.latitude = CLLocationDegrees(latitude) ?? 0
        self.longitude = CLLocationDegrees(longitude) ?? 0
        self.easting = easting
        self.northing = northing
    }
    
}

extension BusLocations {
    static func load(from csvFileLocation : String) -> [BusLocations] {
        guard let filePath = Bundle.main.path(forResource: csvFileLocation, ofType: ".csv") else {
            return []
        }
        var csvContents = [BusLocations]()
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            return []
        }
        
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        
        for row in rows {
            let csvColumns = row.split(separator: ",")
            let location = BusLocations.init(id: String(csvColumns[0]), atcoCode: String(csvColumns[1]), commonName: String(csvColumns[2]), latitude: String(csvColumns[3]), longitude: String(csvColumns[4]), easting: String(csvColumns[5]), northing: String(csvColumns[6]))
            csvContents.append(location)
        }
        return csvContents
    }
}

struct MapView: View {
    @State private var region =  MKCoordinateRegion(
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
        print("HOWDY")
        self.locationManager.delegate = self
        // Request the user to authorize accesing the location when in use
        self.locationManager.requestWhenInUseAuthorization()
        // Try to start updating location if already authorized
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Update published variable with user location coordinates
        userLocation = location.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            // If authorization status has changed to authorized
            // start updating location
            locationManager.startUpdatingLocation()
        }
    }
}
