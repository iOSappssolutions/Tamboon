//
//  SwiftUIView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct FormTextFieldStyle: ViewModifier {
    var isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(15)
            .accentColor(Color("formAccentColor"))
            .background(
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(isActive ? Color("formAccentColor") : Color("formColor"), lineWidth: 2)
            )
    }
}
