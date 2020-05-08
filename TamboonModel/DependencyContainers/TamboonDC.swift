//
//  File.swift
//  TamboonModel
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI
import TamboonModel

class TamboonDC {
    
    
    public init() {
        
        func makeAuthRemoteAPI() -> AuthRemoteAPI {
            return IntensifyAuthRemoteAPI()
        }
        
        func makeSharedUserSssionRepository() -> UserSessionRepository {
            let userSessionDataStore = makeUserSessionDataStore()
            let authRemoteAPI = makeAuthRemoteAPI()
            
            return IntensifyUserSessionRepository(dataStore: userSessionDataStore, remoteAPI: authRemoteAPI)
        }
        
        func makeMainViewModel() -> MainViewModel {
          return MainViewModel()
        }
        
        self.sharedMainViewModel = makeMainViewModel()
        self.sharedUserSessionRepository = makeSharedUserSssionRepository()
        
    }
    
    func makeCharitiesRemoteAPI() -> CharitiesAPI {
        return TamboonCharitiesAPI()
    }
    
    public func makeCharitiesView() -> some View {
        let loginView = makeLoginView()
        let homeViewFactory = { (userSession: UserSession) in
            return self.makeHomeView(session: userSession)
        }
        let starterView = StarterView(loginView: loginView,
                                      makeHomeView: homeViewFactory)
            .environmentObject(loginView.loginViewModel.userSession)
            //.environmentObject(KeyboardFollower())
        sharedUserSession = loginView.loginViewModel.userSession
        return starterView
    }
    
    func makeLoginViewModel()->LoginViewModel {
        return LoginViewModel(userSessionRepository: sharedUserSessionRepository)
    }
    
    public func makeLoginView()-> LoginView {
        let loginViewModel = makeLoginViewModel()
        let loginView = LoginView(loginViewModel: loginViewModel)
        return loginView
    }
    
    func makeHomeView(session: UserSession) -> HomeView {
        let dependencyContainer = makeSignedInDependencyContainer(session: session)
        return dependencyContainer.makeHomeView()
    }
    
    public func makeSignedInDependencyContainer(session: UserSession) -> IntensifySignedInDependencyContainer {
        return IntensifySignedInDependencyContainer(userSession: session, appDependancyContainer: self)
    }
    
}
