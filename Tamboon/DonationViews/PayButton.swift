//
//  PayButton.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 09/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct PayButton: View {
    
    var isPayEnabled: Bool
    
    var payAction: ()->()
    
    var body: some View {
        Button(action: {
            self.payAction()
        }) {
            HStack {
                Spacer()
                
                Text(C.pay)
                
                Spacer()
            }
            .frame(height: 60)
            .foregroundColor(.white)
            .background(isPayEnabled ? Color(C.formAccentColor) : Color(C.formColor) )
            .cornerRadius(5)
        }
    }
}
