//
//  ContentView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI
import TamboonModel
import Combine

struct CharitiesView: View {
    
    @ObservedObject var charitiesViewModel: CharitiesViewModel
    
    var body: some View {
        Group {
            if(charitiesViewModel.charities != nil && charitiesViewModel.charities!.count > 0) {
                Text("")
            } else  {
                NoCharityView()
                    .opacity(charitiesViewModel.isLoading ? 0 : 1)
            }
        }
        .onAppear {
            self.charitiesViewModel.loadCharities()
        }
//        List {
//
//            ForEach(charitiesViewModel.charities) { charity in
//                Text("")
//            }
//        }
    }
    
}

struct CharitiesView_Previews: PreviewProvider {
    static var previews: some View {
        
        CharitiesView(charitiesViewModel: TamboonDC.makeFakeCharitiesViewModel())
    }
}

