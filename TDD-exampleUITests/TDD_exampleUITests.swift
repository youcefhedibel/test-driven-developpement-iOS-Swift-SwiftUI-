//
//  TDD_exampleUITests.swift
//  TDD-exampleUITests
//
//  Created by mac on 9/3/2023.
//

import XCTest

class whenContentViewIsShown: XCTestCase {

    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
    }
    
    
    func testShouldMakeSureThatheTotalTextFieldContainsDefaultValue() {
        XCTAssertEqual(contentViewPage.totalTextField.value as! String, "Enter total")
    }
    
    func testShouldMakeSureThe20PercentDefaultTipOptionIsSelected() {
                
        let segmentedControlButton = contentViewPage.tipPercentageSegmentedControl.buttons.element(boundBy: 1)
        
        XCTAssertEqual(segmentedControlButton.label, "20%")
        XCTAssertTrue(segmentedControlButton.isSelected)
    }
    
    override func tearDown() {
       
    }
}

class whenCalculateTipButtonIsPressedForValidInput: XCTestCase {
    
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
        
        let totalTextField = contentViewPage.totalTextField
        totalTextField.tap()
        totalTextField.typeText("100")
        
        let calculateTipButton = contentViewPage.calculateTipButton
        calculateTipButton.tap()
    }
    
    func testShouldMakeSureThatTipIsDisplayedOnTheScreen() {
                
        let tipText = contentViewPage.tipText
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label,"20.00 DZD")
    }
}

class whenCalculateTipButtonIsPressedForInvalidInput: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let totalTextField = app.textFields["totalTextField"]
        totalTextField.tap()
        totalTextField.typeText("-100")
        
        let calculateTipButton = app.buttons["calculateTipButton"]
        calculateTipButton.tap()
    }
    
    func testShouldClearTipLabelForInvalidInput() {
        
        let tipText = app.staticTexts["tipText"]
        let _ = tipText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(tipText.label, "")
    }
    
    func testShouldDisplayErrorMessageForInvalidInput() {
        
        let messageText = app.staticTexts["messageText"]
        let _ = messageText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(messageText.label, "Invalid Input")
        
    }
    
}
