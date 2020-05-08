//
//  PaymentData.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

struct PaymentData: Encodable {
    
    let name: String
    let token: String
    let amount: Double
    
}
