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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CharityRow_Previews: PreviewProvider {
    static var previews: some View {
        CharityRow(charity: TamboonDC.createFakeCharity())
    }
}
