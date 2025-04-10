//
//  TrafficIncidentsEntry.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 10/04/2025.
//

import Foundation
import WidgetKit

struct TrafficIncidentsEntry: TimelineEntry {
    let date: Date
    let issues: Int
}

extension TrafficIncidentsEntry {
    var hasIssues: Bool {
        return issues > 0
    }

    var placeholder: Bool {
        return date == .distantPast
    }
}
