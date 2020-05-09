//
//  GridView.swift
//  Intensify
//
//  Created by Miroslav Djukic on 14/04/2020.
//  Copyright © 2020 miroslav djukic. All rights reserved.
//

import Foundation
import SwiftUI

struct GridView<Content, T>: View where Content: View {
  var columns: Int
  var items: [T]
  let content: (T) -> Content
    let contentRatio: Double
  
    init(columns: Int, items: [T], contentRatio: Double, @ViewBuilder content: @escaping (T) -> Content) {
    self.columns = columns
    self.items = items
    self.content = content
    self.contentRatio = contentRatio
  }
  
  var numberRows: Int {
    (items.count - 1) / columns
  }
  
  func elementFor(row: Int, column: Int) -> Int? {
    let index = row * self.columns + column
    return index < items.count ? index : nil
  }
  
  var body: some View {
    print("built view")
    return GeometryReader { geometry in
        ScrollView(.vertical, showsIndicators: false) {
        if(self.contentRatio == 1.5) {
            Spacer()
                .frame(height: 127)
        }
        VStack{
          ForEach(0...self.numberRows, id: \.self) { row in
            HStack(spacing: 5) {
              ForEach(0..<self.columns, id: \.self) { column in
                Group {
                  if self.elementFor(row: row, column: column) != nil {
                    self.content(self.items[self.elementFor(row: row, column: column)!])
                        .frame(width: ((geometry.size.width / CGFloat(self.columns)) - (5 * (CGFloat(self.columns) - 1))),
                               height: (geometry.size.width / CGFloat(self.columns)) * CGFloat(self.contentRatio))
                  } else {
                    Spacer()
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

struct GridView_Previews: PreviewProvider {
  static var previews: some View {
    GridView(columns: 3, items: [11, 3, 7, 17, 5, 2, 1], contentRatio: 1.5) { item in
      Text("\(item)")
    }
  }
}
