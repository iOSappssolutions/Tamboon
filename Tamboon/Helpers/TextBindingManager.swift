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

