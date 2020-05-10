//
//  CreditCardFormValidator.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 10/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

public struct CreditCardFormValidator {
    
    // MARK: Validators
    
    public static func getNameValidationMessage(_ name: String) -> String? {
        guard !name.isEmpty else { return nil }
        return validateName(name) ? nil : ""
    }
    
    public static func getCardValidationMessage(_ cardNumber: String) -> String? {
        guard !cardNumber.isEmpty else { return nil }
        return validateCardNumber(cardNumber) ? nil : T.invalidCardMessage
    }
    
    public static func getExpiryYearValidationMessage(_ expYear: String) -> String? {
        guard !expYear.isEmpty else { return nil }
        return validateExpiryYear(expYear) ? nil : T.invalidExpiryYearMessage
    }
    
    public static func getExpiryMonthValidationMessage(_ expMonth: String) -> String? {
        guard !expMonth.isEmpty else { return nil }
        return validateExpiryMonth(expMonth) ? nil : T.invalidExpiryMonthMessage
    }
    
    public static func getSecurityCodeValidationMessage(_ securityCode: String) -> String? {
        guard !securityCode.isEmpty else { return nil }
        return validateSecurityCode(securityCode) ? nil : T.invalidCVVMessage
    }
    
    public static func validateName(_ name: String) -> Bool {
        
        return !name.isEmpty
    }
    
    public static func validateCardNumber(_ cardNumber: String) -> Bool {
        guard !cardNumber.isEmpty else { return false }
        
        let numbers = self.onlyNumbers(string: cardNumber)
        if numbers.count < 9 {
            return false
        }
        
        var reversedString = ""
        let range: Range<String.Index> = numbers.startIndex..<numbers.endIndex
        
        numbers.enumerateSubstrings(in: range, options: [.reverse, .byComposedCharacterSequences]) { (substring, substringRange, enclosingRange, stop) -> () in
            reversedString += substring!
        }
        
        var oddSum = 0, evenSum = 0
        
        for (i, s) in reversedString.enumerated() {
            
            let digit = Int(String(s))!
            
            if i % 2 == 0 {
                evenSum += digit
            } else {
                oddSum += digit / 5 + (2 * digit) % 10
            }
        }
        return (oddSum + evenSum) % 10 == 0
        
    }
    
    public static func validateExpiryMonth(_ expMonth: String) -> Bool {
        guard !expMonth.isEmpty else { return false }
        
        let monthRegex = "^(0?[1-9]|1[012])$"
        
        let monthTest = NSPredicate(format:"SELF MATCHES %@", monthRegex)
        
        let monthResult = monthTest.evaluate(with: expMonth)
        
        return monthResult
    }
    
    public static func validateExpiryYear(_ expYear: String) -> Bool {
        guard !expYear.isEmpty else { return false }
        
        let year = Calendar.current.component(.year, from: Date())
        
        let yearResult = year <= Int(expYear) ?? 0
        
        return yearResult
    }
    
    
    public static func validateSecurityCode(_ securityCode: String) -> Bool {
        guard !securityCode.isEmpty else { return false }
        
        let cvvRegex = "^[0-9]{3,4}$"
        let cvvTest = NSPredicate(format:"SELF MATCHES %@", cvvRegex)
        let result = cvvTest.evaluate(with: securityCode)
        
        return result
    }
    
    private static func onlyNumbers(string: String) -> String {
        let set = CharacterSet.decimalDigits.inverted
        let numbers = string.components(separatedBy: set)
        return numbers.joined(separator: "")
    }
}
