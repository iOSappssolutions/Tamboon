//
//  SwiftUIView.swift
//  Tamboon
//
//  Created by Miroslav Djukic on 09/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import SwiftUI

struct PinPadView: View {
    
    private let currencyDecimalSeparator = "."
    @Binding var currentOutput: String
    @Binding var isExpanded: Bool
    var maxDigits = 2
    
    var body: some View {
        
        let items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", currencyDecimalSeparator, "0", SpecialKeys.delete.rawValue]
        
        return VStack {
            Spacer()
            HStack {
                Spacer()
                Button("Done") {
                    self.isExpanded = false
                }
                .opacity(self.isExpanded ? 1 : 0)
            }
            GridView(columns: 3, items: items) { item in
                Button(action: {
                    if let specialKey = SpecialKeys(rawValue: item) {
                        switch specialKey {
                        case .delete:
                            if self.currentOutput.count > 0 {
                                if self.currentOutput == ("0" + self.currencyDecimalSeparator) {
                                    self.currentOutput = ""
                                } else {
                                    self.currentOutput.remove(at: self.currentOutput.index(before: self.currentOutput.endIndex))
                                }
                            }
                        }
                    } else {
                        if self.shouldAppendChar(char: item)  {
                            self.currentOutput = self.currentOutput + item
                        }
                    }
                }) {
                    self.containedView(item: item)
                }
            }
        }
    }
    
    func containedView(item: String) -> AnyView {
       if let specialKey = SpecialKeys(rawValue: item) {
           return AnyView(
            VStack {
               Spacer()
               
               HStack {
                   Spacer()
                   
                   specialKey.image()
                   
                   Spacer()
               }
              
               
               Spacer()
           })
       } else {
           return AnyView(
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text("\(item)")
                        .font(.title)
                    
                    Spacer()
                }
               
                
                Spacer()
            })
        }
    }
    
    func shouldAppendChar(char: String) -> Bool {
        let decimalLocation = currentOutput.range(of: currencyDecimalSeparator)?.lowerBound

        //Don't allow more that maxDigits decimal points
        if let location = decimalLocation {
            let locationValue = currentOutput.distance(from: currentOutput.endIndex, to: location)
            if locationValue < -maxDigits {
                return false
            }
        }

        //Don't allow more than 2 decimal separators
        if currentOutput.contains("\(currencyDecimalSeparator)") && char == currencyDecimalSeparator {
            return false
        }

        if currentOutput == "0" {
            //Append . to 0
            if char == currencyDecimalSeparator {
                return true

            //Dont append 0 to 0
            } else if char == "0" {
                return false

            //Replace 0 with any other digit
            } else {
                currentOutput = char
                return false
            }
        }

        if char == currencyDecimalSeparator {
            if decimalLocation == nil {
                //Prepend a 0 if the first character is a decimal point
                if currentOutput.count == 0 {
                    currentOutput = "0"
                }
                return true
            } else {
                return false
            }
        }
        return true
    }
}

struct PinPadView_Previews: PreviewProvider {
    static var previews: some View {
        PinPadView(currentOutput: .constant(""), isExpanded: .constant(true))
    }
}

enum SpecialKeys : String {
   case delete = "del"

   func image() -> Image {
       switch self {
       case .delete:
           return Image("Delete")
       }
   }
}
