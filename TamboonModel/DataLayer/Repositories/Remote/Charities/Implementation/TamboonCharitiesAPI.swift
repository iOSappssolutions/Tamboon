//
//  TamboonCharitiesAPI.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public class TamboonCharitiesAPI: CharitiesAPI {
    
    public var session: URLSession = URLSession.configuredURLSession()
    public var baseURL: String = T.baseURL
    
    // MARK: Charities endpoint calls
    
   func getCharities() -> AnyPublisher<CharitiesResponse, Error> {
        return call(endpoint: API.getCharities)
    }
    
    public init() { }
    
}

// MARK: Charities endpoint types

extension TamboonCharitiesAPI {
    
    enum API {
        case getCharities
    }
    
}

// MARK: Request settings

extension TamboonCharitiesAPI.API: APICall {
    
    var path: String {
        switch self {
        case .getCharities:
            return T.getCharities
        }
    }
    
    var method: String {
        switch self {
        case .getCharities:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return ["accept": "application/json"]
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCharities:
            return nil
        }
    }
    
}
