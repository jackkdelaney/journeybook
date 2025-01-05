//
//  ATCORoute.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/01/2025.
//

import Foundation

struct ATCORoute: Codable {
    let vehicle_type: String
    let registration_number: String
    let identifier: String
    let `operator`: String
    let route_number: String
    let first_date_of_operation: String
    let running_board: String
    let last_date_of_operation: String
    let school_term_time: String
    let route_direction: String
    let bank_holidays: String
    let stops: [ATCOStop]
    
}
