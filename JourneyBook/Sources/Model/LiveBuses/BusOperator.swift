//
//  BusOperator.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/01/2025.
//

import SwiftUI

enum BusOperator {
    case metro
    case ulsterbus
    case glider
    case busEireann
    case other

    var colour: Color {
        switch self {
        case .metro: return .pink
        case .ulsterbus: return .blue
        case .glider: return .purple
        case .busEireann: return .green
        case .other: return .black
        }
    }

    static func getOperator(for busOperator: String) -> BusOperator {
        if busOperator == "Ulsterbus" {
            return BusOperator.ulsterbus
        } else if busOperator == "Glider" {
            return BusOperator.glider
        } else if busOperator == "Metro" {
            return BusOperator.metro
        } else if busOperator == "BÉ" {
            return BusOperator.busEireann

        } else {
            return BusOperator.other
        }
    }
}
