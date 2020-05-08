//
//  Charities.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct CharitiesResponse: Decodable {
    
    let total: Int
    let data: [Charity]
    
}
