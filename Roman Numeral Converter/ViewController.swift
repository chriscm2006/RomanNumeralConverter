//
//  ViewController.swift
//  Roman Numeral Converter
//
//  Created by Chris McMeeking on 2/29/16.
//  Copyright © 2016 Chris McMeeking. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var _convertToRomanNumeral: UIButton!
    @IBOutlet weak var _convertToInteger: UIButton!
    @IBOutlet weak var _romanNumeralTextField: UITextField!
    @IBOutlet weak var _integerTextField: UITextField!
    @IBOutlet weak var _statusTextField: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hex values for arrow keys
        _convertToRomanNumeral.setTitle("\u{2B06}", forState: UIControlState.Normal)
        _convertToInteger.setTitle("\u{2B07}", forState: UIControlState.Normal)
        
        convertToRomanNumeral(_integerTextField);
        
        _statusTextField.text = UIStrings.MESSAGE_INTRO
    }

    @IBAction func convertToRomanNumeral(sender: AnyObject) {
        let value = Int(_integerTextField.text!)
        
        do {
            _romanNumeralTextField.text = try RomanNumeralConverter.romanNumeralFromInteger(value!)
            _statusTextField.text = UIStrings.MESSAGE_ROMAN_NUMERAL_CONVERSION_SUCCESS
        } catch RomanNumeralConverter.RomanNumeralError.NonZeroOrNegative {
            _statusTextField.text = UIStrings.MESSAGE_ERROR_VALUE_TOO_SMALL
        } catch RomanNumeralConverter.RomanNumeralError.ValueTooLarge {
            _statusTextField.text = UIStrings.MESSAGE_ERROR_VALUE_TOO_LARGE
        } catch {
            //Other errors should never occur on conversions in this direction
        }
        
        _statusTextField.sizeToFit()
    }

    @IBAction func convertToInteger(sender: AnyObject) {
        let romanNumeral = _romanNumeralTextField.text!
        
        do {
            let value = try RomanNumeralConverter.integerFromRomanNumeral(romanNumeral)
            _integerTextField.text = value.description
            _statusTextField.text = UIStrings.MESSAGE_INTEGER_CONVERSION_SUCCESS
        } catch RomanNumeralConverter.RomanNumeralError.InvalidRomanNumeral {
            _statusTextField.text = UIStrings.MESSAGE_ERROR_INVALID_ROMAN_NUMERAL
        } catch {
            //Other errors should never occur on conversions in this direction
        }
        
    
        _statusTextField.sizeToFit()
    }
}

