//
//  DonationView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import TamboonModel
import Combine

struct DonationView: View {
    
    @ObservedObject var donationsViewModel: DonationViewModel
    @ObservedObject var keyboardHandler: KeyboardFollower = KeyboardFollower()
    @State private var amount: String = "0"
    @State private var name: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var securityCode: String = ""
    @State var isPinPadExpanded = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                FormTextField(title: "Card number",
                              placeHolder: "",
                              getValidationMessage: DonationViewModel.getCardValidationMessage,
                              textEntry: $cardNumber,
                              isPinPadExpanded: $isPinPadExpanded)
            
                FormTextField(title: "Name on card",
                              placeHolder: "",
                              getValidationMessage: DonationViewModel.getNameValidationMessage,
                              textEntry: $name,
                              isPinPadExpanded: $isPinPadExpanded)
                
                HStack(spacing: 50) {
                    FormTextField(title: "ExpiryDate",
                                  placeHolder: "MM/YY",
                                  getValidationMessage: DonationViewModel.getExpiryDateValidationMessage,
                                  textEntry: $expiryDate,
                                  isPinPadExpanded: $isPinPadExpanded)
                    
                    FormTextField(title: "Security code",
                                  placeHolder: "",
                                  getValidationMessage: DonationViewModel.getSecurityCodeValidationMessage,
                                  textEntry: $securityCode,
                                  isPinPadExpanded: $isPinPadExpanded)
                }
            
                AmountView(title: "Amount", placeHolder: "",
                           textEntry: $amount,
                           isPinPadExpanded: $isPinPadExpanded)

                PayButton(payAction: self.pay)
                
                Spacer()
            }
            .offset(y: isPinPadExpanded ? -250 : -1 * keyboardHandler.offset)
            .animation(.easeIn)
            .padding()
        }
    }
    
    func pay() {
        print("pay")
    }
    
}

struct DonationView_Previews: PreviewProvider {
    static var previews: some View {
        DonationView(donationsViewModel: TamboonDC.makeFakeDonationsiewModel())
    }
}

