//
//  ATCOLocation.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/01/2025.
//

import Foundation

struct ATCOLocation: Codable {
    let name: String
    let identifier: String
    let easting: String
    let northing: String?
    let gazeteer_code: String?
}
