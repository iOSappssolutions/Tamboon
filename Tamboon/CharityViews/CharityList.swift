//
//  CharityList.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import TamboonModel

struct CharityList: View {
    
    @Binding var charities: [Charity]
    
    var body: some View {
        List(charities, id: \.id) { charity in
            CharityRow(charity: charity)
        }
    }
}

struct CharityList_Previews: PreviewProvider {
    static var previews: some View {
        
        CharityList(charities: .constant(TamboonDC.getFakeCharities()))
        
    }
}
