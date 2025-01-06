//
//  ATCOStop.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/01/2025.
//

import Foundation

struct ATCOStop: Codable {
    let record_identity: String
    let location: String?
    let published_arrival_time: String?
    let published_departure_time: String?
    let timing_point_indicator: String?
    let fare_stage_indicator: String?
    let bay_number: String?
}

extension ATCOStop: Identifiable {
    var id: String {
        "\(record_identity)-\(location ?? "-")\(niceLocationString)\(published_departure_time)"
    }

    var niceLocationString: String {
        if let location {
            return location
        } else {
            return "Unknown Location"
        }
    }

    var nicePublished_arrival_time: String {
        if let published_arrival_time {
            return published_arrival_time
        } else {
            return "----"
        }
    }

    var nicePublished_departure_time: String {
        if let published_departure_time {
            return published_departure_time
        } else {
            return "----"
        }
    }
}

struct ATCOUnparsed: Codable {
    let line: String
    let line_number: Int
}
