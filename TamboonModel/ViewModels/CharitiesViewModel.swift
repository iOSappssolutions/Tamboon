//
//  CharitiesViewModel.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import Combine

public final class CharitiesViewModel: ObservableObject {
    
    // MARK: properties
    
    private let charitiesAPI: CharitiesAPI
    @Published public var charities: [Charity]? = nil
    @Published public var isLoading: Bool = false
    @Published public var alertMessage: Message? = nil
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
            
            if case .failure(let error) = $0 {
                self.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
            self.isLoading = false
            
        }) { (charitiesResponse) in
            
            self.charities = charitiesResponse.data
            
        }
        .store(in: &subscriptions)
    }
    
}
