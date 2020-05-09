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
        
        return validateName(name) ? nil : ""
    }
    
    public static func getCardValidationMessage(_ cardNumber: String) -> String? {
        
        return validateCardNumber(cardNumber) ? nil : "Credit card number is invalid"
    }
    
    public static func getExpiryDateValidationMessage(_ expDate: String) -> String? {
        
        return validateExpiryDate(expDate) ? nil : "Card expiry date is invalid"
    }
    
    public static func getSecurityCodeValidationMessage(_ securityCode: String) -> String? {
        
        return validateSecurityCode(securityCode) ? nil : "CVV code is not valid"
    }
    
    public static func validateName(_ name: String) -> Bool {
        
        return true
    }
    
    public static func validateCardNumber(_ cardNumber: String) -> Bool {
        
        return false
    }
    
    public static func validateExpiryDate(_ expDate: String) -> Bool {
        
        return false
    }
    
    public static func validateSecurityCode(_ securityCode: String) -> Bool {
        
        return false
    }
    
}

