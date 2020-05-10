//
//  SwiftUIView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 10/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct SuccessView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isDonationOpen: Bool
    var message: String
    
    var body: some View {
        VStack {
            Text(message)
                .padding()
            
            Button(C.dismiss) {
                self.presentationMode.wrappedValue.dismiss()
                self.isDonationOpen = false
            }
            .padding()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(isDonationOpen: .constant(true), message: "test")
    }
}
