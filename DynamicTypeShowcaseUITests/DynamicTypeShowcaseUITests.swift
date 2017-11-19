//
//  DynamicTypeShowcaseUITests.swift
//  DynamicTypeShowcaseUITests
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import XCTest

class DynamicTypeShowcaseUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testForScreenshot() {
        snapshot("Main")

        let app = XCUIApplication()
        let tablesQuery = app.tables

        /// Text Styles
        tablesQuery.staticTexts["Text Styles"].tap()
        let textField = app.textFields["textField"]
        textField.tap()
        sleep(1)
        textField.typeText("Hello\n")
        snapshot("TextStyles")

        app.buttons["SizeChangeButton"]
            .tap()
        app.switches["0"]
            .tap()
        snapshot("SizeChange")
        app.otherElements["PopoverDismissRegion"]
            .tap()

        app.navigationBars.firstMatch.buttons["Menu"].tap()

        /// Image
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Image"]/*[[".cells.staticTexts[\"Image\"]",".staticTexts[\"Image\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("Image")
        app.navigationBars.firstMatch.buttons["Menu"].tap()

        /// Custom Font
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Custom Font"]/*[[".cells.staticTexts[\"Custom Font\"]",".staticTexts[\"Custom Font\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Font"].tap()
        snapshot("FontChange")
        app.otherElements["PopoverDismissRegion"]
            .tap()

        app.navigationBars.firstMatch.buttons["Menu"].tap()
    }
}
