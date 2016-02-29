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
    
    func testExample() {
        XCTAssertEqual(0, RomanNumeralConverter.integerFromRomanNumeralString("Any String"));
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
