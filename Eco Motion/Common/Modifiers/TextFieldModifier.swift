//
//  TextFieldModifier.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    var startColor: Color
    var endColor: Color
    var textColor: Color
    var placeHolderText: String
    func body(content: Content) -> some View {
        VStack(spacing: 5) {
            HStack(){
            Text(placeHolderText)
                    .font(.custom("Charter", size: 20).bold())
                .foregroundColor(startColor)
                Divider()
                    .foregroundColor(startColor)
                content
                    .foregroundColor(textColor)
                    .font(.custom("Charter", size: 20))
            }
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 2)
            
        }
        .padding([.vertical, .horizontal], 10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(startColor, lineWidth: 1)
        )
    }
}

