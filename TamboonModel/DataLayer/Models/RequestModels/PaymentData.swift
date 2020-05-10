//
//  PaymentData.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

public struct PaymentData: Encodable {
    
    public let name: String
    public let token: String
    public let amount: Int
    
}
