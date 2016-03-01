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
    
    private init() {
        _sortedBaseValues = _symbolDictionary.keys.sort()
        
        _sortedBaseSymbols = [String]()
        
        for (value) in _sortedBaseValues {
            _sortedBaseSymbols.append(_symbolDictionary[value]!)
        }
    }
    
    public class func integerFromRomanNumeral (romanNumeral: String) -> Int {
        
        //By uppercasing the string here, our objects don't have to care!
        return instance.getIntegerValue(romanNumeral.uppercaseString)
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
        if (isRomanNumeralInTable(value)) {
            return _symbolDictionary[value]!
        }
        
        if (value == 0) {
            return "";
        }
        
        for (key) in _sortedBaseValues.reverse() {
            if (key <= value) {
                let result = _symbolDictionary[key]! + getRomanNumeral(value - key)
                
                //As we unwind the stack, add the new keys we've found to the dictionary
                addSymbol(result, value: value)
                
                return result
            }
        }
        
        //TODO: Probably throw an exception if we make it this far.
        return "";
    }
    
    private func getIntegerValue(romanNumeral: String) -> Int {
        if (isRomanNumeralInTable(romanNumeral)) {
            let keys = (_symbolDictionary as NSDictionary).allKeysForObject(romanNumeral) as! [Int]
            return keys[0];
        }
        
        for (symbol) in _sortedBaseSymbols.reverse() {
            if (romanNumeral.hasPrefix(symbol)) {
                let restOfRomanNumeral = romanNumeral.substringFromIndex(symbol.endIndex)
                
                return getIntegerValue(symbol) + getIntegerValue(restOfRomanNumeral)
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
