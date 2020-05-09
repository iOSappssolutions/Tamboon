//
//  DonationViewModel.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public final class DonationViewModel: ObservableObject {
    
    // MARK: properties
    
    private let donationApi: DonationsAPI
    @Published public var donation: DonationResponse? = nil
    @Published public var isLoading: Bool = false
    @Published public var alertMessage: Message? = nil
    private var subscriptions = Set<AnyCancellable>()
    private let charity: Charity
    
    // MARK: init
    
    init(charity: Charity, api: DonationsAPI) {
        self.donationApi = api
        self.charity = charity
    }
    
    // MARK: data load
    
    public func placeDonation(name: String,
                              token: String,
                              amount: Double) {
        isLoading = true
        
        donationApi.placeDonation(with: PaymentData(name: name,
                                                    token: token,
                                                    amount: amount))
            
        .sink(receiveCompletion: { [unowned self] in
            
            if case .failure(let error) = $0 {
                self.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
            self.isLoading = false
            
        }) { (donationResponse) in
            
            self.donation = donationResponse
            
        }
        .store(in: &subscriptions)
    }
    
    
    // MARK: Validators
    
    public static func getNameValidationMessage(_ name: String) -> String? {
        guard !name.isEmpty else { return nil }
        return validateName(name) ? nil : ""
    }
    
    public static func getCardValidationMessage(_ cardNumber: String) -> String? {
        guard !cardNumber.isEmpty else { return nil }
        return validateCardNumber(cardNumber) ? nil : "Credit card number is invalid"
    }
    
    public static func getExpiryYearValidationMessage(_ expYear: String) -> String? {
        guard !expYear.isEmpty else { return nil }
        return validateExpiryYear(expYear) ? nil : "Invalid year"
    }
    
    public static func getExpiryMonthValidationMessage(_ expMonth: String) -> String? {
        guard !expMonth.isEmpty else { return nil }
        return validateExpiryMonth(expMonth) ? nil : "Invalid month"
    }
    
    public static func getSecurityCodeValidationMessage(_ securityCode: String) -> String? {
        guard !securityCode.isEmpty else { return nil }
        return validateSecurityCode(securityCode) ? nil : "CVV code is not valid"
    }
    
    private static func validateName(_ name: String) -> Bool {
        
        return true
    }
    
    private static func validateCardNumber(_ cardNumber: String) -> Bool {
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
    
    private static func validateExpiryMonth(_ expMonth: String) -> Bool {
        
        let monthRegex = "^(0?[1-9]|1[012])$"
        
        let monthTest = NSPredicate(format:"SELF MATCHES %@", monthRegex)
        
        let monthResult = monthTest.evaluate(with: expMonth)
        
        return monthResult
    }
    
    private static func validateExpiryYear(_ expYear: String) -> Bool {
        
        let year = Calendar.current.component(.year, from: Date())
        
        let yearResult = year <= Int(expYear) ?? 0
        
        return yearResult
    }
    
    
    private static func validateSecurityCode(_ securityCode: String) -> Bool {
        
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

