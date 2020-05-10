//
//  File.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: Factories

public class TamboonDC {
    
    public init() {}
    
    static func makeCharitiesRemoteAPI() -> CharitiesAPI {
        return TamboonCharitiesAPI()
    }
    
    public static func makeCharitiesViewModel() -> CharitiesViewModel {
        return CharitiesViewModel(api: makeCharitiesRemoteAPI())
    }
        
    static func makeDonationsRemoteAPI() -> DonationsAPI {
        return TamboonDonationsAPI()
    }
    
    public static func makeDonationsViewModel(forCharity: Charity) -> DonationViewModel {
        return DonationViewModel(charity: forCharity, api: makeDonationsRemoteAPI())
    }
    
}

// MARK: Fake view models

extension TamboonDC {
    
    public static func makeFakeCharitiesViewModel() -> CharitiesViewModel {
        let charitiesViewModel = CharitiesViewModel(api: FakeCharitiesAPI())
        charitiesViewModel.charities = getFakeCharities()
        return charitiesViewModel
    }
    
    public static func makeFakeDonationsiewModel() -> DonationViewModel {
        let donationViewModel = DonationViewModel(charity: createFakeCharity(), api: FakeDonationsAPI())
        return donationViewModel
    }
    
    public static func getFakeCharities() -> [Charity] {
        return [createFakeCharity(),
                createFakeCharity(),
                createFakeCharity()]
    }
    
    public static func createFakeCharity() -> Charity {
        return Charity(id: 7331, name: "Habitat for Humanity", logoUrl: "http://www.adamandlianne.com/uploads/2/2/1/6/2216267/3231127.gif")
    }
}
