//
//  URLImage.swift
//  Intensify
//
//  Created by miroslav djukic on 24/02/2020.
//  Copyright © 2020 miroslav djukic. All rights reserved.
//

import Foundation
import SwiftUI
import IntensifyModel

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    @State private var imageLoaded = false
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        self.imageLoader.load(url: url)
    }
    
    @State var image:UIImage = UIImage()
    @State private var opacity = 0.2
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(width:133, height:200)
        }.onReceive(imageLoader.didChange) { data in
            self.image = data?.downloadedImage ?? UIImage()
            withAnimation(.easeInOut(duration: 0.5
            )) {
                self.opacity = 1.0
            }
        }
        .opacity(opacity)
        .imageLoading(isLoading: self.$imageLoader.isLoading)
    }
    
}
