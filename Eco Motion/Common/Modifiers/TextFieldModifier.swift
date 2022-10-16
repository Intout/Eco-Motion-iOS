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
    var textFieldPlaceHolder: String?
    @Binding var isAvailable: String
    func body(content: Content) -> some View {
        VStack(spacing: 5) {
            HStack(){
            Text(placeHolderText)
                    .font(.custom("Charter", size: 20))
                .foregroundColor(startColor)
                Divider()
                    .foregroundColor(startColor)
                ZStack(alignment: .leading){
                    if let text = textFieldPlaceHolder{
                        if isAvailable.isEmpty{
                            Text(text)
                                .foregroundColor(startColor.opacity(0.5))
                        }
                    }
                    content
                        .foregroundColor(textColor)
                        .font(.custom("Charter", size: 20).bold())
                }
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

