//
//  ToolBar.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 10/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI

struct ToolBar: View {
    @ObservedObject var keyboardHandler: KeyboardFollower
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(C.done) {
                        UIResponder.currentFirstResponder?.resignFirstResponder()
                    }
                    .padding(.trailing)
                }
                .frame(height: 40)
                .background(Color(C.formColor))
                .padding(.bottom, self.keyboardHandler.toolBarPosition - geometry.safeAreaInsets.bottom)
            }
            .opacity(self.keyboardHandler.isVisible ? 1 : 0)
        }
    }
}
