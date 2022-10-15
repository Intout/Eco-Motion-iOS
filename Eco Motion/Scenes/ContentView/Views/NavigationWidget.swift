//
//  NavigationWidget.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI

struct NavigationWidget: View {
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            HStack{
                Button("Navigate"){
                    return
                }
                .buttonStyle(LargeButtonStyle())
                Spacer(minLength: 100)
            }
        }
        .padding()
        .background(WidgetBackgroundView(backgroundImage: Image("MapWidgetBackground")), alignment: .bottomLeading)
    }
}

struct NavigationWidget_Previews: PreviewProvider {
    static var previews: some View {
        NavigationWidget()
            
    }
}
