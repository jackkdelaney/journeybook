//
//  JourneyProvider.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 13/04/2025.
//

import Foundation
import SharedPersistenceKit
import SwiftData
import SwiftUI
import WidgetKit

public struct JourneyProvider: @preconcurrency TimelineProvider {
    public func placeholder(in _: Context) -> JourneyTimelineEntry {
        JourneyTimelineEntry(date: .distantPast, type: .placeholder, relevance: TimelineEntryRelevance(score: 0.2))
    }

    public func getSnapshot(in _: Context, completion: @escaping (JourneyTimelineEntry) -> Void) {
        let entry = JourneyTimelineEntry(date: .distantPast, type: .snapshot, relevance: TimelineEntryRelevance(score: 0.2))

        completion(entry)
    }

    @MainActor
    public func getTimeline(in _: Context, completion: @escaping (Timeline<JourneyTimelineEntry>) -> Void) {
        var entries: [JourneyTimelineEntry] = []

        for i in 0 ... 4 {
            let dateOfShwoing = Calendar.current.date(byAdding: .minute, value: i * 25, to: .now)!
            let entry = JourneyTimelineEntry(date: dateOfShwoing, type: .ordinary, relevance: TimelineEntryRelevance(score: 0.2))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)

        completion(timeline)
    }

    public init() {}
}
