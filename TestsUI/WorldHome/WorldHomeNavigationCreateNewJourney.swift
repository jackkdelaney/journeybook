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
    
    func testAddNewJourneyShowsWarningAndWontSaveWithNoData() throws {
        let createNewJourneyButton = app.buttons["Create new Journey"]
        createNewJourneyButton.tap()
        
        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 1), "Add button should exist.")

        addButton.tap()
        
        let alert = app.alerts["Could Not Save"]
        
        XCTAssertTrue(alert.waitForExistence(timeout: 1), "The alert should appear after the button is tapped.")
        
    }
    
    func testAddNewJourneyShowsWarningAndWontSaveWithOnlyDesc() throws {
        let createNewJourneyButton = app.buttons["Create new Journey"]
        createNewJourneyButton.tap()
        
        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 1), "Add button should exist.")

        
        let descriptionField = app.textViews["journeyDescriptionEditor"]
        XCTAssertTrue(descriptionField.waitForExistence(timeout: 2), "Description text editor should exist.")
        
        descriptionField.tap()
        descriptionField.typeText("This is a description of a journey added via XCUI Testing.")

        
        addButton.tap()

        let alert = app.alerts["Could Not Save"]
        
        XCTAssertTrue(alert.waitForExistence(timeout: 1), "The alert should appear after the button is tapped.")
        
    }
    
    func testAddNewJourneyShowsWarningWillSaveWithTitle() throws {
        let createNewJourneyButton = app.buttons["Create new Journey"]
        createNewJourneyButton.tap()
        
        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 1), "Add button should exist.")

        
        let descriptionField = app.textFields["journeyNameField"]
        XCTAssertTrue(descriptionField.waitForExistence(timeout: 2), "Title text editor should exist.")
        
        descriptionField.tap()
        descriptionField.typeText("New Journey \(Date.now.timeIntervalSince1970)")

        
        addButton.tap()

        let alert = app.alerts["Could Not Save"]
        
        XCTAssertTrue(alert.waitForNonExistence(timeout: 1), "The alert should not appear after the button is tapped.")
     
        let sheetTitle = app.navigationBars["Add New Journey"]
        XCTAssertTrue(sheetTitle.waitForNonExistence(timeout: 0.5), "The sheet should disappear with the title 'Add New Journey' no longer shown.")
        

        
    }
    
    

}
