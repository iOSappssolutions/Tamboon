//
//  FakeCharitiesAPI.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public class FakeCharitiesAPI: CharitiesAPI {

    public var session: URLSession = URLSession.configuredURLSession()
    public var baseURL: String = T.baseURL
    
    func getCharities() -> AnyPublisher<CharitiesResponse, Error> {
        return Empty<CharitiesResponse, Error>().eraseToAnyPublisher()
    }

    public init() {}
    
}
