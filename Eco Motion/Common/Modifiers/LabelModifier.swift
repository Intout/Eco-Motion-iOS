//
//  LabelModifier.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import SwiftUI

struct LabelModifier: ViewModifier {
    
    var titleText: String
    var textColor: Color
    
    func body(content: Content) -> some View {
        
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text(titleText)
                    .font(.custom("Charter", size: 20))
                    .foregroundColor(textColor)
                content
                    .foregroundColor(textColor)
                    .font(.custom("Charter", size: 20).bold())
            }
            Rectangle()
                .frame(height: 2)
                .foregroundColor(textColor)
        }
    
    }
}

