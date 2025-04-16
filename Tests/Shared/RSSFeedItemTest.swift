//
//  RSSFeedItemTest.swift
//  SharedPersistenceKit
//
//  Created by Jack Delaney on 16/04/2025.
//

import Foundation
import Testing

@testable import CommonCodeKit

struct RSSFeedItemTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let title = "Test Title"
        let link = "https://example.com/test"
        let description = "This is a test description."
        let pubDate = Date.distantFuture

        let item = RSSFeedItem(title: title, link: link, description: description, pubDate: pubDate)

        #expect(item.title == title)
        #expect(item.link == link)
        #expect(item.description == description)
        #expect(item.pubDate == pubDate)
    }

    @Test
    func testInitialisationSetsPropertiesCorrectlyWhenInittedWithNilValues() {
        let item = RSSFeedItem(title: nil, link: nil, description: nil, pubDate: nil)

        #expect(item.title == nil)
        #expect(item.link == nil)
        #expect(item.description == nil)
        #expect(item.pubDate == nil)
    }

    @Test
    func testEquableForTwoItemsThatAreIndeitcialInID() {
        let item1 = RSSFeedItem(title: "Title 1", link: "alink", description: "desc1", pubDate: .distantPast)
        let item2 = item1

        #expect(item1 == item2)
    }

    @Test
    func testNotEquableForTwoItemsThatAreIndeitcialInIDButSameOtheriwise() {
        let item1 = RSSFeedItem(title: "Title 1", link: "alink", description: "desc", pubDate: .distantPast)
        let item2 = RSSFeedItem(title: "Title 1", link: "alink", description: "desc", pubDate: .distantPast)

        #expect(item1 != item2)
    }

    @Test
    func testTwoEqualValuesHaveSameHash() {
        let item1 = RSSFeedItem(title: "Title 1", link: "alink", description: "desc", pubDate: .distantPast)
        let item2 = item1

        #expect(item1.hashValue == item2.hashValue)
    }
}
