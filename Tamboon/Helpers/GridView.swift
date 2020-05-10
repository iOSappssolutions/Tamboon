//
//  SwiftUIView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 09/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI

struct GridView<Content, T>: View where Content: View {
    var columns: Int
    var items: [T]
    let content: (T) -> Content

  
    init(columns: Int, items: [T], @ViewBuilder content: @escaping (T) -> Content) {
    self.columns = columns
    self.items = items
    self.content = content
  }
  
    var numberRows: Int {
        (items.count - 1) / columns
    }
  
    func elementFor(row: Int, column: Int) -> Int? {
        let index = row * self.columns + column
        return index < items.count ? index : nil
    }
  
    var body: some View {
        return GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 5) {
                    ForEach(0...self.numberRows, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<self.columns, id: \.self) { column in
                                Group {
                                    if self.elementFor(row: row, column: column) != nil {
                                        self.content(self.items[self.elementFor(row: row, column: column)!])
                                        .frame(width: ((geometry.size.width / CGFloat(self.columns)) - (5 * (CGFloat(self.columns) - 1))))
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
    GridView(columns: 3, items: ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "<"]) { item in
      Text("\(item)")
    }
  }
}
