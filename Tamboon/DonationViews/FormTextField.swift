//
//  FormTextField.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 09/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct FormTextField: View {
    
    let title: String
    let placeHolder: String
    var getValidationMessage: (String) -> (String?)
    @State var validationMessage: String? = nil
    @Binding var textEntry: String
    @Binding var isPinPadExpanded: Bool
    @State var isActive = false
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                
                Spacer()
            }
            
            TextField(placeHolder, text: $textEntry, onEditingChanged: { changed in
                if(changed) {
                    self.didStartEditing()
                } else {
                    self.didEndEditing()
                }
            }) {
                self.didEndEditing()
            }
            .modifier(FormTextFieldStyle(isActive: isActive))
            
            HStack {
                Text(validationMessage ?? "")
                    .foregroundColor(Color(.red))
                    .font(.caption)
                
                Spacer()
            }
            .opacity(validationMessage != nil ? 1 : 0)
            .frame(height: 20)
        }
    }
    
    func didStartEditing() {
        self.isPinPadExpanded = false
        self.validationMessage = nil
        self.isActive = true
    }
    
    func didEndEditing() {
        self.validationMessage = self.getValidationMessage(self.textEntry)
        self.isActive = false
    }
}

