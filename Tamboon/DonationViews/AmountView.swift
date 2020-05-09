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
                self.isPinPadExpanded.toggle()
            }, label: {
                HStack {
                    Text(Amount(amount: Double(textEntry) ?? 0, currency: "THB").amountDescription())
                    BlinkingViewWrapper()
                        .opacity(self.isPinPadExpanded ? 0 : 1)
                    Spacer()
                }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color("formColor"), lineWidth: 2)
                )
                    .frame(height: 60)
                //.textFieldStyle(FormTextFieldStyle())
            })
            PinPadView(currentOutput: $textEntry)
                .frame(height: isPinPadExpanded ? 210 : 0)
                .animation(.easeInOut)
        }
    }
}
