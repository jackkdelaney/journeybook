//
//  WidgetRSSFeedManager.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 20/01/2025.
//

import FeedKit
import Foundation

@Observable
class WidgetRSSFeedManager {
    var feedItems: [RSSFeedItem] = []
    var isLoading: Bool = false
    var error: Error?

    var hasItems: Bool {
        !feedItems.isEmpty
    }

    func fetchFeed(from urlString: String) async {
        guard let url = URL(string: urlString) else {
            error = NSError(domain: "Invalid URL", code: 0)
            return
        }

        isLoading = true
        error = nil

        let parser = FeedParser(URL: url)
        let result = parser.parse()

        switch result {
        case let .success(feed):
            switch feed {
            case let .rss(rssFeed):
                feedItems = rssFeed.items?.compactMap { item in
                    RSSFeedItem(
                        title: item.title,
                        link: item.link,
                        description: item.description,
                        pubDate: item.pubDate
                    )
                } ?? []
            case let .atom(atomFeed):
                feedItems = atomFeed.entries?.compactMap { entry in
                    RSSFeedItem(
                        title: entry.title,
                        link: entry.links?.first?.attributes?.href,
                        description: entry.summary?.value,
                        pubDate: entry.published
                    )
                } ?? []
            case let .json(jsonFeed):
                feedItems = jsonFeed.items?.compactMap { item in
                    RSSFeedItem(
                        title: item.title,
                        link: item.url,
                        description: item.contentHtml ?? item.contentText,
                        pubDate: item.datePublished
                    )
                } ?? []
            }

        case let .failure(error):
            print("Feed parsing error: \(error)")
            self.error = error
            feedItems = []
        }
        isLoading = false
    }
}

struct RSSFeedItem: Identifiable {
    let id = UUID()
    let title: String?
    let link: String?
    let description: String?
    let pubDate: Date?
}

extension RSSFeedItem: Equatable, Hashable {
    static func == (lhs: RSSFeedItem, rhs: RSSFeedItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        if let title {
            hasher.combine(title)
        }
    }
}

struct Post: Decodable {
    let id: Int

    let title: String

    let body: String
}
