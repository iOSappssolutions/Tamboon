//
//  SwiftUIView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 09/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import TamboonModel

struct AmountView: View {
    let title: String
    let placeHolder: String
    @Binding var textEntry: String
    @Binding var isPinPadExpanded: Bool

    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
            }
            
            Button(action: {
                self.togglePinPad()
            }, label: {
                HStack(spacing: 1) {
                    Text(formatAmount())
                    
                    BlinkingView()
                        .opacity(self.isPinPadExpanded ? 1 : 0)
                        .frame(height: 20)
                    
                    Spacer()
                }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(isPinPadExpanded ? Color("formAccentColor") : Color("formColor"), lineWidth: 2)
                )
            })
            .buttonStyle(PlainButtonStyle())
            .frame(height: 60)
            
            PinPadView(currentOutput: $textEntry, isExpanded: $isPinPadExpanded)
                .frame(height: isPinPadExpanded ? 250 : 0)
        }
    

    }
    
    private func formatAmount() -> String {
        var hasDecimal = false
        var text = textEntry
        if let last = textEntry.last {
            if(String(last) == "." ) {
                hasDecimal = true
                _ = text.popLast()
            }
        }
        let amount = Amount(amount: Double(text) ?? 0, currency: "THB")
        var formattedAmount = amount.amountDescription()
        
        if(hasDecimal) {
            formattedAmount = amount.withAppendedSymbol(".")
        }
        
        return formattedAmount
    }
    
    private func togglePinPad() {

            self.isPinPadExpanded.toggle()
        
        if(self.isPinPadExpanded) {
            UIResponder.currentFirstResponder?.resignFirstResponder()
        } 
    }
}
