//
//  Amount.swift
//  IntensifyModel
//
//  Created by Miroslav Djukic on 28/04/2020.
//  Copyright © 2020 miroslav djukic. All rights reserved.
//

import Foundation

struct Amount {
    static let precisionDigits = 2
    
    let amount: Double
    let currency: String
    let minimumFractionDigits: Int?
    let maximumFractionDigits: Int
    let negative: Bool
    
    // MARK: - Init
    
    var format: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.locale = LanguageController.shared.getLocale()
        format.generatesDecimalNumbers = true
        format.negativeFormat = "-\(format.positiveFormat!)"
        //format.currencyCode = currency
        format.currencySymbol = Amount.getSymbol(code: currency)
        format.maximumFractionDigits = Amount.precisionDigits
        format.minimumFractionDigits = Amount.precisionDigits
        format.minimumIntegerDigits = 1
        format.usesGroupingSeparator = false
        return format
    }
    
    init(amount: Double,
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
    /*
    private func getSymbol(code: String) -> String {
        let components: [String : String] = [NSLocale.Key.currencyCode.rawValue : code]
        let identifier = Locale.identifier(fromComponents: components)
        return Locale(identifier: identifier).currencySymbol ?? code
    }*/
    
    static func getSymbol(code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    static func getValue(code: String, amountText: String)->String {
        let symbolOpt = getSymbol(code: code)
        guard let symbol = symbolOpt else { return "0"}
        let amountTextStripped = amountText.replacingOccurrences(of: symbol, with: "")
        return amountTextStripped
    }
    
    func amountDescription() -> String {
        guard let currencyString = format.string(from: amount as NSNumber) else { return "" }
        return currencyString
    }
}
