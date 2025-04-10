//
//  RSSFeedManager.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import FeedKit
import Foundation
import CommonCodeKit
@Observable
class RSSFeedManager {
    typealias RSSFeedItem = CommonCodeKit.RSSFeedItem
    
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
