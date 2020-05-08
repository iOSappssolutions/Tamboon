//
//  View+..swift
//  Intensify
//
//  Created by miroslav djukic on 21/02/2020.
//  Copyright © 2020 miroslav djukic. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    public func loading(isLoading: Binding<Bool>) -> some View {
        return LoadingView(isShowing: isLoading) {
            self
        }
    }
    
    public func imageLoading(isLoading: Binding<Bool>) -> some View {
        return ImageLoadingView(isShowing: isLoading) {
            self
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
