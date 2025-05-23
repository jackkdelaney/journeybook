//
//  TranslinkRealTimeBusLocation.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/01/2025.
//

import CoreLocation
import Foundation

struct TranslinkRealTimeBusLocation: RealTimeBusLocation {
    var id: String {
        // swift-format-ignore
        return "\(self.ID)"
    }

    let ID: String
    let Operator: String
    let JourneyIdentifier: String
    let DayOfOperation: String
    let Delay: Int?
    let MOTCode: Int
    let X: String
    let Y: String
    let Timestamp: String
    let XPrevious: String?
    let YPrevious: String?
    let TimestampPrevious: String?
    let VehicleIdentifier: String
    let RealtimeAvailable: Int
    let LineText: String
    let DirectionText: String

    var busNumber: String {
        if LineText.isEmpty {
            JourneyIdentifier
        } else {
            LineText
        }
    }

    var location: CLLocationCoordinate2D {
        .init(latitude: Double(Y) ?? 0, longitude: Double(X) ?? 0)
    }

    var busOperator: BusOperator {
        BusOperator.getOperator(for: Operator)
    }
}

extension TranslinkRealTimeBusLocation: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(Operator)
        hasher.combine(JourneyIdentifier)
    }
}
