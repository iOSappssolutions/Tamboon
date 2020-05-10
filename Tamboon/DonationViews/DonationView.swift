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
    @Binding var isDonationOpen: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 5) {
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

                        VStack(spacing: 15) {
                            AmountView(title: "Amount", placeHolder: "",
                                       textEntry: self.$amount,
                                       isPinPadExpanded: self.$isPinPadExpanded)

                            PayButton(isPayEnabled: self.isPayEnabled(), payAction: self.pay)
                                .disabled(!self.isPayEnabled())
    
                            Spacer()
                        }
                    }
                    .offset(y: -1 * self.keyboardHandler.offset)
                    .padding()
                        
                }
            }
            ToolBar(keyboardHandler: keyboardHandler)
        }
        .navigationBarTitle("", displayMode: .inline)
        .loading(isLoading: $donationsViewModel.isLoading)
        .alert(item: $donationsViewModel.alertMessage) { message in
            Alert(title: Text(message.message), dismissButton: .cancel())
        }
        .sheet(isPresented: $donationsViewModel.successDonation) {
            SuccessView(isDonationOpen: self.$isDonationOpen)
        }
}
    
    func isPayEnabled() -> Bool {
        return DonationViewModel.validateCardNumber(cardNumber)
            && DonationViewModel.validateName(name)
            && DonationViewModel.validateExpiryYear(expiryYear.text)
            && DonationViewModel.validateExpiryMonth(expiryMonth.text)
            && DonationViewModel.validateSecurityCode(securityCode.text)
            && Double(amount) ?? 0 > 0
    }
    
    func pay() {
        guard let amountDouble = Double(amount) else { return }
        print(amountDouble)
        donationsViewModel.pay(name: name,
                               creditCard: cardNumber,
                               cvv: securityCode.text,
                               month: Int(expiryMonth.text)!,
                               year: Int(expiryYear.text)!,
                               amount: amountDouble)
    }
    
}

struct DonationView_Previews: PreviewProvider {
    static var previews: some View {
        DonationView(donationsViewModel: TamboonDC.makeFakeDonationsiewModel(), isDonationOpen: .constant(true))
    }
}

