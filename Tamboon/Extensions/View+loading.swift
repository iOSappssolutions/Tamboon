//
//  View+..swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
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
