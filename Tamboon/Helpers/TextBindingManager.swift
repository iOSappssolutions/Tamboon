//
//  TextBindingManager.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 10/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}

class ExpirationDateBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
            
            if(text.count > oldValue.count) {
                if(text.count == 1) {
                    if(String(text.first!) != "1") {
                        text = "0\(text)"
                    }
                } else if (text.count == 3) {
                    text = "\(oldValue)/\(String(text.last!))"
                } else if (text.count == 5) {
                    text = "\(oldValue)\(String(text.last!))"
                }
            }
            
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}
