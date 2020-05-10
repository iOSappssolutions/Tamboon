
import UIKit
import SwiftUI


struct BlinkingView: View {
    
    let timer = Timer.publish(every: 0.53, on: .main, in: .common).autoconnect()
    @State var isClear: Bool = true
    
    var body: some View {
        Rectangle()
            .frame(width: 2)
            .foregroundColor(isClear ? Color(.clear) : Color(C.formAccentColor))
            .onReceive(timer) { _ in
                self.isClear.toggle()
            }
    }
}
