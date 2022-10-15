//
//  WidgetBackgroundView.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI

struct WidgetBackgroundView: View {
    
    var backgroundImage: Image?
    var backgroundColor: Color = .widgetBackgroundColor
    var cornerRadius: CGFloat = 30
    
    var body: some View {
        GeometryReader{ geometry in
            
            if let image = backgroundImage{
                image
                    .resizable()
                    .cornerRadius(cornerRadius)
                    .imageScale(.large)
                    
            } else {
            Rectangle()
                .cornerRadius(cornerRadius)
                .foregroundColor(backgroundColor)
            }
            
        }
    }
}

struct WidgetBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetBackgroundView()
            .frame(width: 200, height: 200)
            .background(.blue)
    }
}
