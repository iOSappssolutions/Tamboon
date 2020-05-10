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
    
    var charities: [Charity]
    @State var isDonationOpen: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            List(self.charities, id: \.id) { charity in
                NavigationLink(destination: DonationView(donationsViewModel: TamboonDC.makeDonationsViewModel(forCharity: charity),
                               isDonationOpen: self.$isDonationOpen),
                               isActive: self.$isDonationOpen) {
                                
                     CharityRow(charity: charity)
                        .frame(height: ((geometry.size.width / 4) / 2) * 3)
                }
            }
        }
    }
}

struct CharityList_Previews: PreviewProvider {
    static var previews: some View {
        
        CharityList(charities: TamboonDC.getFakeCharities())
        
    }
}
