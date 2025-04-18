//
//  JourneyTimelineEntry.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 13/04/2025.
//

import SharedPersistenceKit
import WidgetKit

public struct JourneyTimelineEntry: TimelineEntry {
    public let date: Date
    public let type: JourneyTimelineEntryType
    public let relevance: TimelineEntryRelevance?

    public init(date: Date, type: JourneyTimelineEntryType, relevance: TimelineEntryRelevance?) {
        self.date = date
        self.type = type
        self.relevance = relevance
    }
}

public enum JourneyTimelineEntryType {
    case ordinary, placeholder, snapshot
}
