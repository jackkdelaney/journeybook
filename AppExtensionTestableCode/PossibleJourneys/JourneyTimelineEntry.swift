//
//  JourneyTimelineEntry.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 13/04/2025.
//

import WidgetKit
import SharedPersistenceKit

struct JourneyTimelineEntry : TimelineEntry {
    let date : Date
    let type : JourneyTimelineEntryType
    let relevance: TimelineEntryRelevance?
}

enum JourneyTimelineEntryType {
   case ordinary, placeholder, snapshot
}
