//
//  Roman_Numeral_ConverterTests.swift
//  Roman Numeral ConverterTests
//
//  Created by Chris McMeeking on 2/29/16.
//  Copyright © 2016 Chris McMeeking. All rights reserved.
//

import XCTest
@testable import Roman_Numeral_Converter

class Roman_Numeral_ConverterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
        Test some of the initial symbols in the table, to make sure our fetching functions work.
    */
    func testBasic() {
        //Test some basic values
        thereAndBackAgain("I", value: 1)
        thereAndBackAgain("IV", value: 4)
        thereAndBackAgain("V", value: 5)
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
