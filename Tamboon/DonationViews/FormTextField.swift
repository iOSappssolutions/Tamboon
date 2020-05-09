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
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                
                Spacer()
            }
            TextField(placeHolder, text: $textEntry, onEditingChanged: { changed in
                if(changed) {
                    self.isPinPadExpanded = false
                } else {
                    self.validationMessage = self.getValidationMessage(self.textEntry)
                }
            }) {
                self.validationMessage = self.getValidationMessage(self.textEntry)
            }
            .textFieldStyle(FormTextFieldStyle())
            if(validationMessage != nil) {
                HStack {
                    Text(validationMessage!)
                        .foregroundColor(Color(.red))
                        .font(.caption)
                    
                    Spacer()
                }
            }
        }
    }
}

