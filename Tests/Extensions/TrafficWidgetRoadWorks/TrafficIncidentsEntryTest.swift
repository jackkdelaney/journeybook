//
//  TrafficIncidentsEntryTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 17/04/2025.
//

import AppExtensionJBKit
import Foundation
import Testing

@testable import JourneyBook

struct TrafficIncidentsEntryTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let entry = TrafficIncidentsEntry(date: .distantFuture, issues: 2)

        #expect(entry.date == .distantFuture)
        #expect(entry.issues == 2)
    }

    @Test
    func testHasIssuesWithIssues() {
        let entry = TrafficIncidentsEntry(date: .distantFuture, issues: 2)

        #expect(entry.hasIssues == true)
    }

    @Test
    func testHasIssuesWithIssuesEdgeCase() {
        let entry = TrafficIncidentsEntry(date: .distantFuture, issues: 2)

        #expect(entry.hasIssues == true)
    }

    @Test
    func testHasIssuesWithNoIssues() {
        let entry = TrafficIncidentsEntry(date: .distantFuture, issues: 0)

        #expect(entry.hasIssues == false)
    }

    @Test
    func testPlaceholderNot() {
        let entry = TrafficIncidentsEntry(date: .distantFuture, issues: 0)

        #expect(entry.placeholder == false)
    }

    @Test
    func testPlaceholder() {
        let entry = TrafficIncidentsEntry(date: .distantPast, issues: 0)

        #expect(entry.placeholder == true)
    }
}
