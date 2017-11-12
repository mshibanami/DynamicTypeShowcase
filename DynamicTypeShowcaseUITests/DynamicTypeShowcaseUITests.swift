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

    func testExample() {
        snapshot("Main")

        let app = XCUIApplication()
        let tablesQuery = app.tables

        /// Text Styles
        tablesQuery.staticTexts["Text Styles"].tap()
        let textField = app.textFields["textField"]
        textField.tap()
        sleep(1)
        textField.typeText("Hello\n")
        app.navigationBars.firstMatch.buttons["Menu"].tap()
        snapshot("TextStyles")

        /// Image
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Image"]/*[[".cells.staticTexts[\"Image\"]",".staticTexts[\"Image\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars.firstMatch.buttons["Menu"].tap()
        snapshot("Image")

        /// Custom Font
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Custom Font"]/*[[".cells.staticTexts[\"Custom Font\"]",".staticTexts[\"Custom Font\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars.firstMatch.buttons["Menu"].tap()
        snapshot("CustomFont")
    }
}
