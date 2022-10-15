//
//  DestinationWidget.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import SwiftUI

struct DestinationWidget: View {
    
    var fromText: String?
    var toText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text(fromText ?? "Current Location")
                .modifier(LabelModifier(titleText: "From", textColor: .blue))
            Text(toText)
                .modifier(LabelModifier(titleText: "To", textColor: .green))
        }
        .padding([.horizontal], 20)
        .padding([.vertical], 30)
        .background(WidgetBackgroundView())
    }
}

struct DestinationWidget_Previews: PreviewProvider {
    static var previews: some View {
        DestinationWidget(toText: "Paris")
    }
}
