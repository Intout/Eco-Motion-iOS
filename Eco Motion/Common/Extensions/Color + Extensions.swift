//
//  Color + Extensions.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import Foundation
import SwiftUI

public extension Color{
   static var buttonTitleColor: Color{
        return .init(red: 0.397, green: 0.55, blue: 0.325)
    }
   static var widgetBackgroundColor: Color{
        return .init(red: 0.898, green: 0.898, blue: 0.898).opacity(0.23)
    }
    static var buttonColor: Color{
        return .init(red: 0.8, green: 1, blue: 0.8)
    }
    static var statBackgroundColor: Color{
        return .init(red: 202/255, green: 253/255, blue: 171/255)
    }
}
