//
//  CharitiesViewModel.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public final class CharitiesViewModel {
    
    // MARK: properties
    
    private let charitiesAPI: CharitiesAPI
    @Published public var charities: [Charity]? = nil
    @Published public var isLoading: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: init
    
    init(api: CharitiesAPI) {
        self.charitiesAPI = api
    }
    
    // MARK: data load
    
    public func loadCharities() {
        isLoading = true
        charitiesAPI.getCharities()
        .sink(receiveCompletion: { [unowned self] in
            
            print($0)
            self.isLoading = false
            
        }) { (charitiesResponse) in
            
            self.charities = charitiesResponse.data
            
        }
        .store(in: &subscriptions)
    }
    
}
