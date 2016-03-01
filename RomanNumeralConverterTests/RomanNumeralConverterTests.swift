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
        50: "L",
        99: "XCIX",
        100: "C",
        500:"D",
        533:"DXXXIII",
        534:"DXXXIV",
        890: "DCCCXC",
        900:"CM",
        1800: "MDCCC"
    ]
    
    override func setUp() {
        super.setUp()
        
        RomanNumeralConverter.resetCache()
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
        thereAndBackAgain(_correctDictionary[500]!, value: 500)
        thereAndBackAgain(_correctDictionary[900]!, value: 900)
    }
    
    func getIntegerFromNumeralIgnoreThrow(value: String) -> Int {
        do {
            return try RomanNumeralConverter.integerFromRomanNumeral(value)
        } catch {
            XCTFail("It should not throw an error in these tests")
        }
        
        return 0
    }
    
    //Test all values in the dictionary converting it to a roman numeral.
    func testRomanNumeralsFromIntegers() {
        
        RomanNumeralConverter.resetCache()
        
        //Sort the keys, so that the tests run predictably
        for (key) in _correctDictionary.keys.sort() {
            XCTAssertEqual(_correctDictionary[key], RomanNumeralConverter.romanNumeralFromInteger(key))
        }
    }
    
    func testIntegerFromRomanNumeral() {
                
        for (key) in _correctDictionary.keys.sort() {
            XCTAssertEqual(key, getIntegerFromNumeralIgnoreThrow(_correctDictionary[key]!))
        }
    }
    
    let PERFORMANCE_MAX_VALUE = 1000

    func testPerformanceIntegerFromRomanNumeral() {
        
        self.measureBlock {
            RomanNumeralConverter.resetCache()
            
            self.fetchAllRomanNumeralsUpTo(self.PERFORMANCE_MAX_VALUE)
        }
    }
    
    
    func testPerformanceIntegerFromRomanNumeral_caching() {
        
        self.fetchAllRomanNumeralsUpTo(PERFORMANCE_MAX_VALUE)
        
        //After asking for each value, they should be in the cache, so requesting them the other way around should run
        //very quickly.
        self.measureBlock {
            self.fetchAllRomanNumeralsUpTo(self.PERFORMANCE_MAX_VALUE)
        }
    }
    
    func testRomanNumeralsWithErrors() {
        XCTAssertTrue(XCTAssertThrows {
            try RomanNumeralConverter.integerFromRomanNumeral("CCCC")
        })
        
        XCTAssertTrue(XCTAssertThrows {
            try RomanNumeralConverter.integerFromRomanNumeral("IM")
        })
    }
    
    /*
    We send a roman numeral and its associated value through a bidirectional test.
    
    Return true on success.
    */
    func thereAndBackAgain(romanNumeral: String, value:Int) {
        XCTAssertEqual(romanNumeral, RomanNumeralConverter.romanNumeralFromInteger(value))
        
        XCTAssertEqual(value, getIntegerFromNumeralIgnoreThrow(romanNumeral))
    }
    
    func fetchAllRomanNumeralsUpTo(value: Int) {
        for i in 1...value {
            RomanNumeralConverter.romanNumeralFromInteger(i)
        }
    }
    
    func XCTAssertThrows(block: () throws -> ()) -> Bool {
        do {
            try block()
            return false
        }
        catch {
            return true
        }
    }
    
}
