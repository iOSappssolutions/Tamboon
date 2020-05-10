//
//  Constants.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct T {
    
    // MARK: Base URL
    
    static let baseURL = "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0/"
    
    // MARK: Endpoints
    
    static let placeDonation = "donations"
    static let getCharities = "charities"
    
    // MARK: Locale string constants
    
    static let currencyCode = "THB"
    static let locale = "th"
    
    // MARK: Validation message string constants
    
    static let invalidCardMessage = "Credit card number is invalid"
    static let invalidExpiryMonthMessage = "Invalid month"
    static let invalidExpiryYearMessage = "Invalid year"
    static let invalidCVVMessage = "CVV code is not valid"
    
    // MARK: Omise SDK key
    
    static let omiseKey = "pkey_test_5jt7wzlwesogyowyugv"
}
