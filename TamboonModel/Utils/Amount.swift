//
//  Amount.swift
//  IntensifyModel
//
//  Created by Miroslav Djukic on 28/04/2020.
//  Copyright © 2020 miroslav djukic. All rights reserved.
//

import Foundation

public struct Amount {
    public static let precisionDigits = 2
    
    let amount: Double
    let currency: String
    let minimumFractionDigits: Int?
    let maximumFractionDigits: Int
    let negative: Bool
    
    // MARK: - Init
    
    public var format: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.locale = Locale(identifier: T.locale)
        format.generatesDecimalNumbers = true
        format.negativeFormat = "-\(format.positiveFormat!)"
        format.currencySymbol = Amount.getSymbol(code: T.currencyCode)
        format.maximumFractionDigits = Amount.precisionDigits
        format.minimumFractionDigits = 0
        format.minimumIntegerDigits = 1
        format.maximumIntegerDigits = 15
        format.usesGroupingSeparator = false
        return format
    }
    
    public init(amount: Double,
         currency: String,
         minimumFractionDigits: Int? = nil,
         maximumFractionDigits: Int = Amount.precisionDigits,
         negative: Bool = false) {
        
        self.amount = amount
        self.currency = currency
        self.minimumFractionDigits = minimumFractionDigits
        self.maximumFractionDigits = maximumFractionDigits
        self.negative = negative
    }
    
    // MARK: - Convenience Accessors
    
    var description: String {
        return amountDescription()
    }
    
    public static func getSymbol(code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    public static func getValue(code: String, amountText: String)->Double? {
        let symbolOpt = getSymbol(code: code)
        guard let symbol = symbolOpt else { return nil}
        let amountTextStripped = amountText.replacingOccurrences(of: symbol, with: "")
        let amountWhiteSpacesStripped = amountTextStripped.replacingOccurrences(of: " ", with: "")
        return Double(amountWhiteSpacesStripped)
    }
    
    public func withAppendedSymbol(_ char: String) -> String {
        var currentStringValue = amountDescription()
        if let range = currentStringValue.range(of: String(Amount.getSymbol(code: T.currencyCode) ?? "")) {
            
            if(range.upperBound == currentStringValue.endIndex) {
                currentStringValue.insert(contentsOf: char, at: currentStringValue.index(before: range.lowerBound))
            } else {
                currentStringValue += char
            }
        }
        
        return currentStringValue
    }
    
    public func amountDescription() -> String {
        guard let currencyString = format.string(from: amount as NSNumber) else { return "" }
        return currencyString
    }
}
