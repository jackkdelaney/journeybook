//
//  WaterProvider.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 16/01/2025.
//

import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in _: Context) -> TrafficIncidentsEntry {
        TrafficIncidentsEntry(date: Date.distantPast, issues: 2)
    }

    func getSnapshot(in _: Context,

                     completion: @escaping (TrafficIncidentsEntry) -> Void)
    {
        let entry = TrafficIncidentsEntry(date: .distantPast, issues: 0)

        completion(entry)
    }

    func getTimeline(in _: Context,

                     completion: @escaping

                     (Timeline<TrafficIncidentsEntry>) -> Void)
    {
        fetchData { issuesFound in

            let currentDate = Date()

            let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!

            let entry = TrafficIncidentsEntry(
                date: currentDate,

                issues: issuesFound
            )

            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))

            completion(timeline)
        }
    }

    private func fetchData(completion: @escaping (Int) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data, error == nil else {
                print("Failed to fetch data")

                return
            }

            let posts = try? JSONDecoder().decode([Post].self, from: data)

            completion(posts?.count ?? 0)
        }

        task.resume()
    }
}

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
