//
//  FakeDonationsAPI.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

class FakeDonationsAPI: DonationsAPI {
    
    public var session: URLSession = URLSession.configuredURLSession()
    public var baseURL: String = T.baseURL
    
    func placeDonation(with payment: PaymentData) -> AnyPublisher<DonationResponse, Error> {
        return Empty<DonationResponse, Error>().eraseToAnyPublisher()
    }

    public init() { }
}
