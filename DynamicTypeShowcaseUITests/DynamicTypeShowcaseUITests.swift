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
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Sizes"]/*[[".cells[\"sizesCell\"].staticTexts[\"Sizes\"]",".staticTexts[\"Sizes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.textFields["textField"]
        textField.tap()
        sleep(1)
        textField.typeText("Hello\n")
        
        snapshot("Sizes")
    }
}
