//
//  CharityRow.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import TamboonModel

struct CharityRow: View {
    
    let charity: Charity

    var body: some View {
        GeometryReader { geometry in
            HStack {
                URLImage(url: self.charity.logoUrl)
                .frame(width: geometry.size.width / 4)
                .clipped()
                .cornerRadius(5)
                Text(self.charity.name)
                
                Spacer()
            }
        }
    }
}

struct CharityRow_Previews: PreviewProvider {
    static var previews: some View {
        CharityRow(charity: TamboonDC.createFakeCharity())
    }
}
