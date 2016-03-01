//
//  RomanNumeralConverterUITests.swift
//  RomanNumeralConverterUITests
//
//  Created by Chris McMeeking on 2/29/16.
//  Copyright © 2016 Chris McMeeking. All rights reserved.
//

import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) -> Void {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        var deleteString: String = ""
        for _ in stringValue.characters {
            deleteString += "\u{8}"
        }
        self.typeText(deleteString)
        
        self.typeText(text)
    }
}

class RomanNumeralConverterUITests: XCTestCase {
    
    var _app = XCUIApplication()
    
    //Initialize these to temp values that will be overwritten
    var _downArrow: XCUIElement?
    var _upArrow: XCUIElement?
    var _textInteger: XCUIElement?
    var _textRomanNumeral: XCUIElement?
    var _textStatus: XCUIElement?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        _app.launch()
        
        _downArrow = _app.buttons["downArrow"]
        _upArrow = _app.buttons["upArrow"]
        _textRomanNumeral = _app.textFields["romanNumeral"]
        _textInteger = _app.textFields["integerValue"]
        _textStatus = _app.staticTexts["status"]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Minimal state checking to see if things load correctly.  If this test fails everything else is hozed!
    func testInitialization() {

        
        XCTAssertTrue(_downArrow!.exists)
        //Our two conversion buttons
        XCTAssertEqual(_app.buttons.count, 2)
        
        //Roman numeral text field and integer value text field
        XCTAssertEqual(_app.textFields.count, 2)
        
        //The three labels (one fore each text field, and our status label)
        XCTAssertEqual(_app.staticTexts.count, 3)
        
    }
    
    
    func testConvertToInteger() {

        testInitialization()
        
        _textRomanNumeral!.clearAndEnterText("MMCC")
        
        _downArrow!.tap()
        
        XCTAssertEqual(_textInteger!.value?.description, "2200")
        
        XCTAssertEqual(_textStatus?.label, UIStrings.MESSAGE_INTEGER_CONVERSION_SUCCESS)
    }
    
    func testConvertToRomanNumeral() {
        
        testInitialization()
        
        _textInteger!.clearAndEnterText("3888")
        _upArrow!.tap()
        
        XCTAssertEqual(_textRomanNumeral!.value?.description, "MMMDCCCLXXXVIII")
        
    }
    
    func testErrorIntegerTooLarge() {
        
        testInitialization()
        
        _textInteger!.clearAndEnterText("3889")
        _upArrow!.tap()
        
        XCTAssertEqual(_textStatus!.label, UIStrings.MESSAGE_ERROR_VALUE_TOO_LARGE)
    }
    
    func testErrorIntegerTooSmall() {
        testInitialization()
        
        _textInteger!.clearAndEnterText("0")
        _upArrow!.tap()
        
        XCTAssertEqual(_textStatus!.label, UIStrings.MESSAGE_ERROR_VALUE_TOO_SMALL)
    }
    
    func testErrorInvalidRomanNumeral1() {
        testInitialization()
        
        _textRomanNumeral!.clearAndEnterText("CCCC")
        _downArrow!.tap()
        
        XCTAssertEqual(_textStatus!.label, UIStrings.MESSAGE_ERROR_INVALID_ROMAN_NUMERAL)
    }
    
}
