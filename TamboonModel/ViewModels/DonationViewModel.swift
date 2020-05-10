//
//  DonationViewModel.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine
import OmiseSDK

public final class DonationViewModel: ObservableObject {
    
    // MARK: properties
    
    private let donationApi: DonationsAPI
    @Published public var successDonation: Bool = false
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
            
            if(donationResponse.success) {
                self.successDonation = true
            } else {
                self.alertMessage = Message(id: 0, message: donationResponse.errorMessage ?? "")
            }
            
            
        }
        .store(in: &subscriptions)
    }
    
    public func pay(name: String,
                    creditCard: String,
                    cvv: String,
                    month: Int,
                    year: Int,
                    amount: Double) {
        
        let client = OmiseSDK.Client.init(publicKey: "pkey_test_5jt7wzlwesogyowyugv")
        
        let tokenParameters = Token.CreateParameter(
            name: name,
            number: creditCard,
            expirationMonth: month,
            expirationYear: year,
            securityCode: cvv
        )
        
        let request = Request<Token>(parameter: tokenParameters)
        isLoading = true
        client.send(request) { [weak self] (tokenResult) in
            guard let s = self else { return }
            switch tokenResult {
            case .success(let value):
                s.placeDonation(name: name, token: value.id, amount: amount)
            case .failure(let error):
                s.isLoading = false
                s.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
            
          
        }
        
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

