//
//  AddNewJourneyAndWorkOnJourney.swift
//  JourneyBookTestsUI
//
//  Created by Jack Delaney on 16/04/2025.
//

import XCTest

final class AddNewJourneyAndWorkOnJourney: XCTestCase {
    let app = XCUIApplication()

    let id = UUID().uuidString.prefix(5)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["UITests"]
        app.launch()

        let createNewJourneyButton = app.buttons["Create new Journey"]

        XCTAssertTrue(createNewJourneyButton.exists, "The 'Create New Journey' button should exist.")
        createNewJourneyButton.tap()

        let sheetTitle = app.navigationBars["Add New Journey"]
        XCTAssertTrue(sheetTitle.waitForExistence(timeout: 0.5), "The sheet should appear with the title 'Add New Journey'.")

        let descriptionField = app.textViews["journeyDescriptionEditor"]
        XCTAssertTrue(descriptionField.waitForExistence(timeout: 2), "Description text editor should exist.")

        descriptionField.tap()
        descriptionField.typeText("This is a description of a journey added via XCUI Testing.")

        let nameField = app.textFields["journeyNameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 2), "Title text editor should exist.")

        nameField.tap()
        nameField.typeText("\(id)")

        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 1), "Add button should exist.")

        addButton.tap()

        let navigateButton = app.buttons["\(id)"]
        XCTAssertTrue(navigateButton.waitForExistence(timeout: 1), "Button with name should exist")
        navigateButton.tap()
    }

    func testJourneyBookHasCorrectTitle() throws {
        let navTitle = app.navigationBars["\(id)"]
        XCTAssertTrue(
            navTitle.waitForExistence(timeout: 2),
            "\(id)' page should be visible."
        )
    }

    func testDescriptionShown() throws {
        let description = app.staticTexts["This is a description of a journey added via XCUI Testing."]
        XCTAssertTrue(
            description.waitForExistence(timeout: 2),
            "\(description)' should should be visible."
        )
    }

    func testEditButtonShown() throws {
        let editButton = app.navigationBars.buttons["Edit"]
        XCTAssertTrue(
            editButton.waitForExistence(timeout: 2), "Edit Button should should be visible."
        )
        editButton.tap()

        let editTitleAndDesc = app.buttons["Edit Title and Description"]
        XCTAssertTrue(
            editTitleAndDesc.waitForExistence(timeout: 2), "Edit Title and Description should be visible."
        )

        editTitleAndDesc.tap()

        let updateButton = app.navigationBars.buttons["Update"]
        let cancelButton = app.navigationBars.buttons["Cancel"]
        let editJourney = app.navigationBars["Edit Journey"]

        XCTAssertTrue(
            updateButton.waitForExistence(timeout: 2), "Update should be visible"
        )
        XCTAssertTrue(
            cancelButton.waitForExistence(timeout: 2), "Cancel Should be Visible"
        )
        XCTAssertTrue(
            editJourney.waitForExistence(timeout: 2), "Edit Journey should be visible."
        )

        cancelButton.tap()
    }

    func testAddNewStep() throws {
        let addNewStep = app.buttons["AddNewStepButton"]

        XCTAssertTrue(
            addNewStep.waitForExistence(timeout: 2), "Add New Step should be present"
        )
        addNewStep.tap()
    }

    func testAddNewStepHasCancelButton() throws {
        let addNewStep = app.buttons["AddNewStepButton"]

        XCTAssertTrue(
            addNewStep.waitForExistence(timeout: 2), "Add New Step should be present"
        )
        addNewStep.tap()

        let cancelButton = app.navigationBars.buttons["Cancel"]
        XCTAssertTrue(
            cancelButton.waitForExistence(timeout: 2), "Cancel Should be Visible"
        )
        cancelButton.tap()
    }

    func testAddNewStepHasSavwButtonAndIsDisbled() throws {
        let addNewStep = app.buttons["AddNewStepButton"]

        XCTAssertTrue(
            addNewStep.waitForExistence(timeout: 2), "Add New Step should be present"
        )
        addNewStep.tap()

        let saveButton = app.navigationBars.buttons["Save"]
        XCTAssertTrue(
            saveButton.waitForExistence(timeout: 2), "save Should be Visible"
        )
        XCTAssertTrue(
            !saveButton.isEnabled, "save should not be enabled"
        )
    }
}