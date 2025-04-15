//
//  RSSFeedManagerTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 15/04/2025.
//

import CommonCodeKit
import Testing

import Foundation
@testable import JourneyBook

struct RSSFeedManagerTests {
    @MainActor @Test
    func testInitialisationSetsDefaultPropertiesCorrectly() {
        let model = RSSFeedManager()

        #expect(model.feedItems.isEmpty)
        #expect(model.isLoading == false)
        #expect(model.error == nil)
    }

    @MainActor @Test
    func testEmptyManagerHasNoItems() {
        let model = RSSFeedManager()

        #expect(model.hasItems == false)
    }

    @MainActor @Test
    func testManagerWithItemsHasItems() {
        let model = RSSFeedManager()

        model.feedItems = mockedItems()

        #expect(model.hasItems == true)
    }

    @MainActor @Test
    func testManagerWithItemsHasItemsCountCheck() {
        let model = RSSFeedManager()

        model.feedItems = mockedItems()

        #expect(model.feedItems.count == 3)

        model.feedItems = Array(mockedItems().prefix(1))
        #expect(model.feedItems.count == 1)
    }

    @MainActor @Test
    func testFetchFeedEmptyURL() async {
        let model = RSSFeedManager()

        await model.fetchFeed(from: "")

        let expectedErorr = NSError(domain: "Invalid URL", code: 0)

        if let actualError = model.error as? NSError {
            #expect(actualError == expectedErorr)

        } else {
            #expect(false == true, "Incorrect Type")
        }
        #expect(model.error != nil)
    }

    private func mockedItems() -> [RSSFeedItem] {
        [
            RSSFeedItem(
                title: "Apple Annouces new iPhone",
                link: "https://www.apple.com/",
                description: "A New iPhone was annouced",
                pubDate: Date.distantFuture
            ),
            RSSFeedItem(
                title: "Apple Annouces new iPhone 4",
                link: "https://www.apple.com/",
                description: "A New iPhone was annouced",
                pubDate: Date.distantPast
            ),
            RSSFeedItem(
                title: "Apple Annouces new iPhone 4S",
                link: "https://www.apple.com/",
                description: "A New iPhone was annouced",
                pubDate: Date.now
            ),
        ]
    }
}
