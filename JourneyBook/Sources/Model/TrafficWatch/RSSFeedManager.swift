//
//  RSSFeedManager.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import Foundation
import FeedKit

@Observable
class RSSFeedManager {
    var feedItems: [RSSFeedItem] = []
    var isLoading: Bool = false
    var error: Error?

    var hasItems : Bool {
        !feedItems.isEmpty
    }
    
    func fetchFeed(from urlString: String) async {
        guard let url = URL(string: urlString) else {
            self.error = NSError(domain: "Invalid URL", code: 0)
            return
        }

        self.isLoading = true
        self.error = nil

        let parser = FeedParser(URL: url)
        let result = parser.parse()

        switch result {
        case .success(let feed):
            switch feed {
            case .rss(let rssFeed):
                self.feedItems = rssFeed.items?.compactMap { item in
                    RSSFeedItem(
                        title: item.title,
                        link: item.link,
                        description: item.description,
                        pubDate: item.pubDate
                    )
                } ?? []
            case .atom(let atomFeed):
                self.feedItems = atomFeed.entries?.compactMap { entry in
                    RSSFeedItem(
                        title: entry.title,
                        link: entry.links?.first?.attributes?.href,
                        description: entry.summary?.value,
                        pubDate: entry.published
                    )
                } ?? []
            case .json(let jsonFeed):
                self.feedItems = jsonFeed.items?.compactMap { item in
                    RSSFeedItem(
                        title: item.title,
                        link: item.url,
                        description: item.contentHtml ?? item.contentText,
                        pubDate: item.datePublished
                    )
                } ?? []
            }

        case .failure(let error):
            print("Feed parsing error: \(error)")
            self.error = error
            self.feedItems = []
        }
        self.isLoading = false
    }
}
