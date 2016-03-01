//
//  RomanNumeralConverterTests.swift
//  RomanNumeralConverterTests
//
//  Created by Chris McMeeking on 2/29/16.
//  Copyright © 2016 Chris McMeeking. All rights reserved.
//

import XCTest
@testable import RomanNumeralConverter

class RomanNumeralConverterTests: XCTestCase {
    
    //A collection of any correct symbols we believe may be useful for testing.  Comprising most of the 
    //first 20 or so symbols, and a few of the more complex ones (border cases).
    let _correctDictionary = [
        1: "I",
        2: "II",
        3: "III",
        4: "IV",
        5: "V",
        6: "VI",
        7: "VII",
        8: "VIII",
        9: "IX",
        10: "X",
        13: "XIII",
        14: "XIV",
        18: "XVIII",
        19: "XIX",
        20: "XX",
        40: "XL",
        43: "XLIII",
        44: "XLIV",
        50: "L"
    ]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
    Test some of the initial symbols in the table, to make sure our fetching functions work.
    None of these calls should manipulate the data in the table, only double check that things
    have initialized properly and that our getters and setters are working.
    */
    func testInitialization() {
        thereAndBackAgain(_correctDictionary[1]!, value: 1)
        thereAndBackAgain(_correctDictionary[4]!, value: 4)
        thereAndBackAgain(_correctDictionary[5]!, value: 5)
        thereAndBackAgain(_correctDictionary[10]!, value: 10)
        thereAndBackAgain(_correctDictionary[9]!, value: 9)
        thereAndBackAgain(_correctDictionary[50]!, value: 50)
    }
    
    //Test all values in the dictionary converting it to a roman numeral.
    func testRomanNumeralFromInteger() {
        for (key) in _correctDictionary.keys {
            XCTAssertEqual(_correctDictionary[key], RomanNumeralConverter.romanNumeralFromInteger(key))
        }
    }
    
    func testIntegerFromRomanNumeral() {
        for (key) in _correctDictionary.keys {
            XCTAssertEqual(key, RomanNumeralConverter.integerFromRomanNumeral(_correctDictionary[key]!))
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    /*
    We send a roman numeral and its associated value through a bidirectional test.
    
    Return true on success.
    */
    func thereAndBackAgain(romanNumeral: String, value:Int) {
        XCTAssertEqual(romanNumeral, RomanNumeralConverter.romanNumeralFromInteger(value))
        XCTAssertEqual(value, RomanNumeralConverter.integerFromRomanNumeral(romanNumeral))
    }
    
}
