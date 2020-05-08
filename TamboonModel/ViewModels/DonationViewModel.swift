//
//  DonationViewModel.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public final class DonationViewModel {
    
    // MARK: properties
    
    private let donationApi: DonationsAPI
    @Published public var donation: DonationResponse? = nil
    @Published public var isLoading: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: init
    
    init(api: DonationsAPI) {
        self.donationApi = api
    }
    
    // MARK: data load
    
    public func loadCharities(name: String,
                              token: String,
                              amount: Double) {
        isLoading = true
        
        donationApi.placeDonation(with: PaymentData(name: name,
                                                    token: token,
                                                    amount: amount))
            
        .sink(receiveCompletion: { [unowned self] in
            
            print($0)
            self.isLoading = false
            
        }) { (donationResponse) in
            
            self.donation = donationResponse
            
        }
        .store(in: &subscriptions)
    }
    
}
