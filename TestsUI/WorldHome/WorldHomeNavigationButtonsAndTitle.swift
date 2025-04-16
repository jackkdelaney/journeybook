//
//  WorldHomeNavigationButtonsAndTitle.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 14/04/2025.
//

import XCTest

final class WorldHomeNavigationButtonsAndTitle: XCTestCase {
    let app = XCUIApplication()


    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["UITests"]
        app.launch()
    }

    func testJourneyBookTitle() throws {
        let mainPageTitle = app.navigationBars["JourneyBook"]

        XCTAssertTrue(mainPageTitle.exists, "The main page title should be 'JourneyBook'.")
    }

    func testCreditButton() throws {
        let creditsButton = app.buttons["Credits"]

        XCTAssertTrue(
            creditsButton.exists,
            "The 'Credits' button should exist in the navigation toolbar."
        )

        creditsButton.tap()

        let creditsTitle = app.navigationBars["Credits"]
        XCTAssertTrue(
            creditsTitle.waitForExistence(timeout: 2),
            "The 'Credits' screen should be visible."
        )
    }

    func testBriefcaseOptionResourceManangerButton() throws {
        try testBriefcaseOption(
            menuButtonText: "Resource Manager",
            navigationText: "Resources"
        )
    }

    func testBriefcaseOptionTransportRouteButton() throws {
        try testBriefcaseOption(
            menuButtonText: "Transport Routes",
            navigationText: "Transport Routes"
        )
    }

    func testBriefcaseOptionGliderButton() throws {
        try testBriefcaseOption(
            menuButtonText: "GliderProofConcept",
            navigationText: "Bus Stops"
        )
    }

    func testBriefcaseOptionCommunicationButton() throws {
        try testBriefcaseOption(
            menuButtonText: "Communication Directory",
            navigationText: "Communication"
        )
    }

    func testBriefcaseOptioPhraseBookButton() throws {
        try testBriefcaseOption(
            menuButtonText: "Phrase Book",
            navigationText: "Phrase Book"
        )
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

    private func testBriefcaseOption(
        menuButtonText: String,
        navigationText: String
    ) throws {
        let menuButton = app.buttons["Options"]
        XCTAssertTrue(
            menuButton.exists,
            "The 'Options' menu button should exist."
        )

        menuButton.tap()

        let menuButtonInternalButton = app.buttons[menuButtonText]
        XCTAssertTrue(
            menuButtonInternalButton.waitForExistence(timeout: 0.5),
            "The '\(menuButtonText)' menu item should exist."
        )
        menuButtonInternalButton.tap()

        let navTitle = app.navigationBars[navigationText]
        XCTAssertTrue(
            navTitle.waitForExistence(timeout: 2),
            "\(navigationText)' page should be visible."
        )
    }
}
