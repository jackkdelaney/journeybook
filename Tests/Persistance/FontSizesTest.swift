//
//  FontSizesTest.swift
//  JourneyBook
//
//  Created by Jack Delaney on 16/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct FontSizesTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let font = FontSizes.body

        #expect(font.rawValue == 3)
        #expect(font.fontStyle == .body)
    }

    @Test
    func testFontSizeLargeTitle() {
        let font = FontSizes.largeTitle

        #expect(font.fontStyle == .largeTitle)
    }

    @Test
    func testFontSizeTitle() {
        let font = FontSizes.title1

        #expect(font.fontStyle == .title)
    }

    @Test
    func testFontSizeTitle2() {
        let font = FontSizes.title2

        #expect(font.fontStyle == .title2)
    }

    @Test
    func testFontSizeTitle3() {
        let font = FontSizes.title3

        #expect(font.fontStyle == .title3)
    }

    @Test
    func testFontSizeHeadline() {
        let font = FontSizes.headline

        #expect(font.fontStyle == .headline)
    }

    @Test
    func testFontSizeSubHeadline() {
        let font = FontSizes.subheadline

        #expect(font.fontStyle == .subheadline)
    }

    @Test
    func testFontSizeCallout() {
        let font = FontSizes.callout

        #expect(font.fontStyle == .callout)
    }

    func testFontSizeFootnote() {
        let font = FontSizes.footnote

        #expect(font.fontStyle == .footnote)
    }

    func testFontSizeCaption() {
        let font = FontSizes.caption

        #expect(font.fontStyle == .caption)
    }

    func testFontSizeCaption2() {
        let font = FontSizes.caption2

        #expect(font.fontStyle == .caption2)
    }
}
