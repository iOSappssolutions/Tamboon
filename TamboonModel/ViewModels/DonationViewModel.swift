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
    public var donation: DonationResponse? = nil
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
    
    // MARK: Donation placing functions
    
    public func placeDonation(name: String,
                              token: String,
                              amount: Int) {
        isLoading = true
        
        donationApi.placeDonation(with: PaymentData(name: name,
                                                    token: token,
                                                    amount: amount))
            
        .sink(receiveCompletion: { [unowned self] in
            
            if case .failure(let error) = $0 {
                self.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
            self.isLoading = false
            
        }) { [unowned self] (donationResponse) in
            
            if(donationResponse.success) {
                self.successDonation = true
                self.donation = donationResponse
            } else {
                self.alertMessage = Message(id: 0, message: donationResponse.errorMessage ?? "")
            }
            
            
        }
        .store(in: &subscriptions)
    }
    
    
    public func pay(name: String,
                    creditCard: String,
                    cvv: String,
                    month: String,
                    year: String,
                    amount: String) {
        
        guard let month = Int(month), let year = Int(year) else { return }
        
        let client = OmiseSDK.Client.init(publicKey: T.omiseKey)
        
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
                s.placeDonation(name: name, token: value.id, amount: Int(amount)!)
            case .failure(let error):
                s.isLoading = false
                s.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
        }
    }
}

