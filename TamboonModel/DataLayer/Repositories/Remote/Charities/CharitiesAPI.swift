//
//  CharitiesAPI.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

protocol CharitiesAPI: WebRepository {
    
    func getCharities() -> AnyPublisher<CharitiesResponse, Error>
    
}
