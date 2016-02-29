//
//  RomanNumeralConverter.swift
//  Roman Numeral Converter
//
//  Created by Chris McMeeking on 2/29/16.
//  Copyright © 2016 Chris McMeeking. All rights reserved.
//

import Foundation

class RomanNumeralConverter {
    
    //We use a singleton pattern to easily reset state if something gets corrupted.
    private static let instance = RomanNumeralConverter()
    
    private var _symbolDictionary = [Int: String]()
    
    private init() {
        addSymbol("I", value: 1);
        addSymbol("IV", value: 4);
        addSymbol("V", value: 5);
        addSymbol("IX", value: 9);
        addSymbol("X", value: 10);
    }
    
    class func integerFromRomanNumeral (romanNumeral: String) -> Int {
        return instance.getIntegerValue(romanNumeral);
    }
    
    class func romanNumeralFromInteger (value: Int) -> String {
        return instance.getRomanNumeral(value)
    }
    
    /*Add a new symbol to the dictionary.  Returns true if the symbol was added.
        False if for some reason it was not.
        TODO: This should perhaps throw an excption instead of returning a bool?
    */
    private func addSymbol(symbol:String, value:Int) -> Bool {
        
        if (_symbolDictionary.keys.contains(16)) {
            return false;
        }
        
        _symbolDictionary[value] = symbol;
        
        return true;
    }
    
    
    private func getRomanNumeral(value: Int) -> String {
        if (isRomanNumeralInTable(value)) {
            return _symbolDictionary[value]!
        }
        
        return "";
    }
    
    private func getIntegerValue(romanNumeral: String) -> Int {
        if (isRomanNumeralInTable(romanNumeral)) {
            let keys = (_symbolDictionary as NSDictionary).allKeysForObject(romanNumeral) as! [Int]
            return keys[0];
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
