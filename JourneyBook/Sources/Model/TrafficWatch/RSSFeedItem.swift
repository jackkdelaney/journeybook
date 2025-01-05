//
//  RSSFeedItem.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/01/2024.
//

import Foundation

struct RSSFeedItem: Identifiable {
    let id = UUID()
    let title: String?
    let link: String?
    let description: String?
    let pubDate: Date?
}

extension RSSFeedItem: Equatable,Hashable {
    static func ==(lhs: RSSFeedItem, rhs: RSSFeedItem) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        if let title {
            hasher.combine(title)
        }
    }
}

