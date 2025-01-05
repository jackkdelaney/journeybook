//
//  BusLocations.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import CoreLocation
import Foundation

struct BusLocations: Identifiable {
    var id: String
    var atcoCode: String
    var commonName: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var easting: String
    var northing: String

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
    static func load(from csvFileLocation: String) -> [BusLocations] {
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
            let location = BusLocations(id: String(csvColumns[0]), atcoCode: String(csvColumns[1]), commonName: String(csvColumns[2]), latitude: String(csvColumns[3]), longitude: String(csvColumns[4]), easting: String(csvColumns[5]), northing: String(csvColumns[6]))
            csvContents.append(location)
        }
        return csvContents
    }
}
