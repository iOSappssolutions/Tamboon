//
//  URLImage.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI
import TamboonModel

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
