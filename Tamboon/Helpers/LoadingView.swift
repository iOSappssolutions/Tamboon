//
//  LoadingView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 08/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text(C.loading)
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

struct ImageLoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
               
                
                AnimatedGradientView1(width: geometry.size.width, height: geometry.size.height)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct AnimatedGradientView1: View {
    
    @State var gradient = [Color(.white), Color(.purple)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let width: CGFloat
    let height: CGFloat
    var foreverAnimation: Animation {
           Animation.easeInOut(duration: 1)
            .repeatForever(autoreverses: true)

    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
            .frame(width: width, height: height)
            .animation(foreverAnimation)
            .onReceive(timer) { value in
                self.startPoint = UnitPoint(x: 1, y: -1)
                self.endPoint = UnitPoint(x: 0, y: 1)
            }
            .onAppear() {
                self.startPoint = UnitPoint(x: 1, y: -1)
                self.endPoint = UnitPoint(x: 0, y: 1)
            }
    }
    
    func onReceive() {
        self.startPoint = UnitPoint(x: 1, y: -1)
        self.endPoint = UnitPoint(x: 0, y: 1)
    }
}


