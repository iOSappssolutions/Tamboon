
import UIKit
import SwiftUI

class KeyboardFollower : ObservableObject {
  @Published var offset: CGFloat = 0
  @Published var toolBarPosition: CGFloat = 0
  @Published var isVisible = false
  
  init() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardVisibilityChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc private func keyboardVisibilityChanged(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    guard let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
    
    isVisible = keyboardEndFrame.minY < UIScreen.main.bounds.height
    let currentResponderPosition = UIResponder.currentFirstResponder?.globalFrame?.maxY
    if let currentRP = currentResponderPosition {
        toolBarPosition = keyboardEndFrame.height
        if keyboardEndFrame.origin.y - 60 < currentRP {
            offset += currentRP - keyboardEndFrame.origin.y + 60
        } else {
            if(!isVisible) {
                offset = 0
                toolBarPosition = 0
            }
        }
        
    }
  }
}
