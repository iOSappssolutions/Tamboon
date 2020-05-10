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
        return Just(CharitiesResponse(total: 10, data: [Charity(id: 0,
                                                                name: "test name",
                                                                logoUrl: "http://www.adamandlianne.com/uploads/2/2/1/6/2216267/3231127.gif")]))
            .mapError({_ in 
                APIError.unexpectedResponse
            })
            .eraseToAnyPublisher()
        
    }

    public init() {}
    
}
