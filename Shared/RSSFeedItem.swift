//
//  RSSFeedItem.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 11/04/2025.
//

import Foundation

public struct RSSFeedItem: Identifiable {
    public let id = UUID()
    public let title: String?
    public let link: String?
    public let description: String?
    public let pubDate: Date?
    
    public init(title: String?, link: String?, description: String?, pubDate: Date?) {
        self.title = title
        self.link = link
        self.description = description
        self.pubDate = pubDate
    }
}

extension RSSFeedItem: Equatable, Hashable {
    public static func == (lhs: RSSFeedItem, rhs: RSSFeedItem) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        if let title {
            hasher.combine(title)
        }
    }
}
