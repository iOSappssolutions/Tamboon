//
//  DonationsAPI.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public protocol DonationsAPI: WebRepository {
    
    func placeDonation(with payment: PaymentData) -> AnyPublisher<DonationResponse, Error>
    
}
