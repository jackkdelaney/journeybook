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
    var latitude : String
    var longitude : String
    var easting : String
    var northing : String
    
    init(id: String, atcoCode: String, commonName: String, latitude: String, longitude: String, easting: String, northing: String) {
        self.id = id
        self.atcoCode = atcoCode
        self.commonName = commonName
        self.latitude = latitude
        self.longitude = longitude
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
//    @State private var position = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
//            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//        )
//    )
    
    var locations = BusLocations.load(from: "november-cords")
    
    var body: some View {
        List(locations) { location in
            Text(location.commonName)
        }

    }
}
