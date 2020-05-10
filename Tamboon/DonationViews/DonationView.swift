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
    @ObservedObject private var expiryMonth = TextBindingManager(limit: 2)
    @ObservedObject private var expiryYear = TextBindingManager(limit: 4)
    @ObservedObject private var securityCode = TextBindingManager(limit: 4)
    @State private var amount: String = "0"
    @State private var name: String = ""
    @State private var cardNumber: String = ""
    @State var isPinPadExpanded = false
    @State var isCardActive = false
    @State var isNameActive = false
    @State var isMonthActive = false
    @State var isYearActive = false
    @State var isSecurityActive = false
    
    @Binding var isDonationOpen: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ZStack {
                            HStack(spacing: 0) {
                                Text(self.formatCreditCardLabel())
                                BlinkingView()
                                .opacity(self.isCardActive ? 1 : 0)
                                .frame(height: 20)
                                Spacer()
                            }
                            .padding()
                            
                            FormTextField(title: "Card number",
                                      placeHolder: "",
                                      getValidationMessage: DonationViewModel.getCardValidationMessage,
                                      textEntry: self.$cardNumber,
                                      isPinPadExpanded: self.$isPinPadExpanded,
                                      isActive: self.$isCardActive,
                                      hideInput: true)
                            .keyboardType(.numberPad)
                        }
                       
                        
                        FormTextField(title: "Name on card",
                                      placeHolder: "",
                                      getValidationMessage: DonationViewModel.getNameValidationMessage,
                                      textEntry: self.$name,
                                      isPinPadExpanded: self.$isPinPadExpanded,
                                      isActive: self.$isNameActive)
                        
        
                        HStack(alignment: .top, spacing: 5) {
                            HStack(spacing: 5) {
                                FormTextField(title: "Expiry month",
                                              placeHolder: "MM",
                                              getValidationMessage: DonationViewModel.getExpiryMonthValidationMessage,
                                              textEntry: self.$expiryMonth.text,
                                              isPinPadExpanded: self.$isPinPadExpanded,
                                              isActive: self.$isMonthActive)
                                .keyboardType(.numberPad)
                        
                                FormTextField(title: "Expiry year",
                                              placeHolder: "YYYY",
                                              getValidationMessage: DonationViewModel.getExpiryYearValidationMessage,
                                              textEntry: self.$expiryYear.text,
                                              isPinPadExpanded: self.$isPinPadExpanded,
                                              isActive: self.$isYearActive)
                                .keyboardType(.numberPad)
                            }
                            .frame(width: (geometry.size.width / 3) * 1.77 )
                            
                            FormTextField(title: "Security code",
                                          placeHolder: "",
                                          getValidationMessage: DonationViewModel.getSecurityCodeValidationMessage,
                                          textEntry: self.$securityCode.text,
                                          isPinPadExpanded: self.$isPinPadExpanded,
                                          isActive: self.$isSecurityActive)
                            .keyboardType(.numberPad)
                        }

                        VStack(spacing: 15) {
                            AmountView(title: "Amount", placeHolder: "",
                                       textEntry: self.$amount,
                                       isPinPadExpanded: self.$isPinPadExpanded)

                            PayButton(isPayEnabled: self.isPayEnabled(),
                                      payAction: self.pay)
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
    
    func formatCreditCardLabel() -> String {
        return cardNumber.separate(every: 4, with: " ")
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

extension String {
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}
