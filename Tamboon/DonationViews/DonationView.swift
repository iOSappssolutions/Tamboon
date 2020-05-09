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
    @ObservedObject private var expiryMonth = TextBindingManager(limit: 2)
    @ObservedObject private var expiryYear = TextBindingManager(limit: 4)
    @ObservedObject private var securityCode = TextBindingManager(limit: 4)
    @State var isPinPadExpanded = false
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    FormTextField(title: "Card number",
                                  placeHolder: "",
                                  getValidationMessage: DonationViewModel.getCardValidationMessage,
                                  textEntry: self.$cardNumber,
                                  isPinPadExpanded: self.$isPinPadExpanded)
                        .keyboardType(.numberPad)
                
                    FormTextField(title: "Name on card",
                                  placeHolder: "",
                                  getValidationMessage: DonationViewModel.getNameValidationMessage,
                                  textEntry: self.$name,
                                  isPinPadExpanded: self.$isPinPadExpanded)
                    
    
                    HStack(alignment: .top, spacing: 10) {
                        HStack(spacing: 5) {
                            FormTextField(title: "Expiry month",
                                          placeHolder: "MM",
                                          getValidationMessage: DonationViewModel.getExpiryMonthValidationMessage,
                                          textEntry: self.$expiryMonth.text,
                                          isPinPadExpanded: self.$isPinPadExpanded)
                            .keyboardType(.numberPad)
                    
                            FormTextField(title: "Expiry year",
                                          placeHolder: "YYYY",
                                          getValidationMessage: DonationViewModel.getExpiryYearValidationMessage,
                                          textEntry: self.$expiryYear.text,
                                          isPinPadExpanded: self.$isPinPadExpanded)
                            .keyboardType(.numberPad)
                        }
                        .frame(width: (geometry.size.width / 3) * 1.8 )
                        
                        FormTextField(title: "Security code",
                                      placeHolder: "",
                                      getValidationMessage: DonationViewModel.getSecurityCodeValidationMessage,
                                      textEntry: self.$securityCode.text,
                                      isPinPadExpanded: self.$isPinPadExpanded)
                        .keyboardType(.numberPad)
                    }

                
                    AmountView(title: "Amount", placeHolder: "",
                               textEntry: self.$amount,
                               isPinPadExpanded: self.$isPinPadExpanded)

                    PayButton(payAction: self.pay)
                        .disabled(!self.isPayEnabled())
                        .opacity(self.isPayEnabled() ? 1 : 0.4)
                    Spacer()
                }
                .offset(y: self.isPinPadExpanded ? -250 : -1 * self.keyboardHandler.offset)
                //.animation(.easeIn)
                .padding()
                    
            }
            }
            ToolBar(keyboardHandler: keyboardHandler)
        }
}
    
    func isPayEnabled() -> Bool {
        return !cardNumber.isEmpty
            && !name.isEmpty
            && !expiryYear.text.isEmpty
            && !expiryMonth.text.isEmpty
            && !securityCode.text.isEmpty
            && Double(amount) ?? 0 > 0
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

