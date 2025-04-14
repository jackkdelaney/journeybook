//
//  WorldHomeNavigationCreateNewJourney.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 14/04/2025.
//

import XCTest

final class WorldHomeNavigationCreateNewJourney: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testCreateNewJourneyButton() throws {
        let createNewJourneyButton = app.buttons["Create new Journey"]
        
        XCTAssertTrue(createNewJourneyButton.exists, "The 'Create New Journey' button should exist.")
        createNewJourneyButton.tap()
        
        
        let sheetTitle = app.navigationBars["Add New Journey"]
        XCTAssertTrue(sheetTitle.waitForExistence(timeout: 0.5), "The sheet should appear with the title 'Add New Journey'.")
        
    }
    
    func testTextFieldInsideSheet() throws {
        let createNewJourneyButton = app.buttons["Create new Journey"]
        createNewJourneyButton.tap()

        let sheetTitle = app.navigationBars["Add New Journey"]
        XCTAssertTrue(sheetTitle.waitForExistence(timeout: 0.5), "The sheet should appear with the title 'Add New Journey'.")
        
        
        let headerJourneyDesc = app.staticTexts["JourneyDescriptionSection"]
        XCTAssertTrue(headerJourneyDesc.waitForExistence(timeout: 0.5), "The sheet should contain the header 'Journey Description'.")
        
        let headerJourneyNames = app.staticTexts["JourneyNameSection"]
        XCTAssertTrue(headerJourneyNames.exists, "The sheet should contain the header 'Journey Name'.")
        
            
    }
    
    
//    func testLaunchPerformance() throws {
//        // This measures how long it takes to launch your application.
//        measure(metrics: [XCTApplicationLaunchMetric()]) {
//            XCUIApplication().launch()
//        }
//    }
}
