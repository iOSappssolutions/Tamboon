//
//  ImageLoader.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public class ImageLoader: ObservableObject {
    
    @Published public var downloadedImage: UIImage?
    @Published public var isLoading: Bool = false
    public let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    public init() {
        
    }
    
    public func load(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        isLoading = true
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                     self.didChange.send(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedImage = UIImage(data: data)
                self.didChange.send(self)
            }
            
        }.resume()
    
    }
    
    
}
