//
//  TrafficIncidentsEntry.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 10/04/2025.
//

import Foundation
import WidgetKit

public struct TrafficIncidentsEntry: TimelineEntry {
    public let date: Date
    public let issues: Int
    
    public init(date: Date, issues: Int) {
        self.date = date
        self.issues = issues
    }
}

extension TrafficIncidentsEntry {
   public var hasIssues: Bool {
        return issues > 0
    }

    public var placeholder: Bool {
        return date == .distantPast
    }
}
