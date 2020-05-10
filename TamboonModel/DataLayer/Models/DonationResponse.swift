//
//  DonationResponse.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

public struct DonationResponse: Decodable {
    
    public var success: Bool
    public let errorCode: String?
    public let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
    
}
