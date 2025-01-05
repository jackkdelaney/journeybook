//
//  ATCOHeader.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/01/2025.
//

import Foundation

struct ATCOHeader: Codable {
    let file_type: String
    let version: String
    let file_originator: String
    let source_product: String
    let production_datetime: String?
}
