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
        NavigationView {
            Group {
                if(charitiesViewModel.charities != nil && charitiesViewModel.charities!.count > 0) {
                    CharityList(charities: self.charitiesViewModel.charities!)
                } else  {
                    NoCharityView()
                        .opacity(charitiesViewModel.isLoading ? 0 : 1)
                }
            }
            .navigationBarTitle("Charities")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.charitiesViewModel.loadCharities()
        }
    }
    
}

struct CharitiesView_Previews: PreviewProvider {
    static var previews: some View {
        
        CharitiesView(charitiesViewModel: TamboonDC.makeFakeCharitiesViewModel())
    }
}

