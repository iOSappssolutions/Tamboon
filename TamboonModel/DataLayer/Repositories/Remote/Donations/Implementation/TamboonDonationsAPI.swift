//
//  File.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

class TamboonDonationsAPI: DonationsAPI {
    
    public var session: URLSession = URLSession.configuredURLSession()
    public var baseURL: String = C.baseURL
    
    // MARK: Donation endpoint calls
    
    func placeDonation(with payment: PaymentData) -> AnyPublisher<DonationResponse, Error> {
        return call(endpoint: API.placeDonations(payment))
    }
    
    public init() { }
    
}

// MARK: Donation endpoint types

extension TamboonDonationsAPI {
    
    enum API {
        case placeDonations(PaymentData)
    }
    
}

// MARK: Request settings

extension TamboonDonationsAPI.API: APICall {
    
    var path: String {
        switch self {
        case .placeDonations:
            return C.placeDonation
        }
    }
    
    var method: String {
        switch self {
        case .placeDonations:
            return "POST"
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json", "accept": "application/json"]
    }
    
    func body() throws -> Data? {
        switch self {
        case let .placeDonations(payment):
            return try createPlaceDonationBody(payment)
        }
    }
    
    func createPlaceDonationBody(_ payment: PaymentData) throws -> Data? {
        return try JSONEncoder().encode(payment)
    }
    
}
