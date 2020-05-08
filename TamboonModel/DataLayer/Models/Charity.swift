//
//  Charity.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

public struct Charity: Decodable {
    
    public let id: Int
    public let name: String
    public let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logoUrl = "logo_url"
    }
    
}
