//
//  RomanNumeralConverter.swift
//  Roman Numeral Converter
//
//  Created by Chris McMeeking on 2/29/16.
//  Copyright © 2016 Chris McMeeking. All rights reserved.
//

import Foundation

public class RomanNumeralConverter {
    
    //We use a singleton pattern to easily reset state if something gets corrupted.
    private static var instance = RomanNumeralConverter()
    
    //By including IV, IX, XL,... in the symbol table, we trivialize some of the more
    //complicated roman numeral requirements.
    private var _symbolDictionary = [
        1: "I",
        4: "IV",
        5: "V",
        9: "IX",
        10: "X",
        40: "XL",
        50: "L",
        90: "XC",
        100: "C",
        400: "CD",
        500: "D",
        900: "CM",
        1000: "M"
    ]
    
    private var _sortedBaseValues:[Int]
    
    private var _sortedBaseSymbols:[String]
    
    private let _repeatableSymbols = ["I", "X", "C", "M"]
    
    private let MAX_REPEATS = 3
    
    private init() {
        _sortedBaseValues = _symbolDictionary.keys.sort()
        
        _sortedBaseSymbols = [String]()
        
        for (value) in _sortedBaseValues {
            _sortedBaseSymbols.append(_symbolDictionary[value]!)
        }
    }
    
    enum RomanNumeralError: ErrorType {
        case InvalidRomanNumeral
    }
    
    public class func integerFromRomanNumeral (romanNumeral: String) throws -> Int {
        
        //By uppercasing the string here, our objects don't have to care!
        let result = instance.getIntegerValue(romanNumeral.uppercaseString)
        
        //Super hacky error handling.  My solution for repeating symbols being adding extra
        //symbols to the table ("IV", XC" etc) makes error handling tricker.  So instead, I just
        //check the reverse process, and make sure that the result is the same as the value input.
        //This may actually be fairly performant given how fast my iterative algorithm is for
        //calculating proper roman numerals.
        let correctRomanNumeral = instance.getRomanNumeral(result)
        
        if (correctRomanNumeral.compare(romanNumeral) == NSComparisonResult.OrderedSame) {
            return result
        } else {
            throw RomanNumeralError.InvalidRomanNumeral
        }
    }
    
    public class func romanNumeralFromInteger (value: Int) -> String {
        return instance.getRomanNumeral(value)
    }
    
    class func resetCache() {
        instance = RomanNumeralConverter()
    }
    
    /*Add a new symbol to the dictionary.  Returns true if the symbol was added.
        False if for some reason it was not.
        TODO: This should perhaps throw an excption instead of returning a bool?
    */
    private func addSymbol(symbol:String, value:Int) -> Bool {
        
        if (_symbolDictionary.keys.contains(value)) {
            return false;
        }
        
        //We shouldn't have to upper case, bust since this is adding new symbols we do just in case.
        _symbolDictionary[value] = symbol.uppercaseString;
        
        return true;
    }
    
    
    private func getRomanNumeral(value: Int) -> String {
        
        var result = ""
        
        var remainingValue = value
        for (key) in _sortedBaseValues.reverse() {
            if (key <= remainingValue) {

                let symbol = _symbolDictionary[key]!

                if (_repeatableSymbols.contains(symbol)) {
                    for _ in 1...MAX_REPEATS {
                        if (key <= remainingValue) {
                            result += symbol
                            remainingValue -= key
                        }
                    }
                } else {
                    result += symbol
                    remainingValue -= key
                }
            }
        }
        
        //TODO: Probably throw an exception if we make it this far.
        return result;
    }
    
    private func getIntegerValue(romanNumeral: String) -> Int {
        if (isRomanNumeralInTable(romanNumeral)) {
            let keys = (_symbolDictionary as NSDictionary).allKeysForObject(romanNumeral) as! [Int]
            return keys[0];
        }
        
        for (symbol) in _sortedBaseSymbols.reverse() {
            if (romanNumeral.hasPrefix(symbol)) {
                let restOfRomanNumeral = romanNumeral.substringFromIndex(symbol.endIndex)
                
                
                let symbolValue = getIntegerValue(symbol)
                let theRestValue = getIntegerValue(restOfRomanNumeral)
                
                return theRestValue + symbolValue;
            }
        }
        
        return 0;
    }
    
    private func isRomanNumeralInTable(romanNumeral: String) -> Bool {
        return _symbolDictionary.values.contains(romanNumeral);
    }
    
    private func isRomanNumeralInTable(value: Int) -> Bool {
        return _symbolDictionary.keys.contains(value);
    }
    
    
}
