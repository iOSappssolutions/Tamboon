//
//  NoCharityView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct NoCharityView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("No charities at the moment")
                    .font(.title)
                    .padding(.top, geometry.size.height / 4)
                
                Spacer()
            }
        }
    }
    
}

struct NoCharityView_Previews: PreviewProvider {
    static var previews: some View {
        NoCharityView()
    }
}
