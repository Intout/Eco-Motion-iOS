//
//  TripPlannerWidget.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI

struct TripPlannerWidget: View {
    
    @State var destinationFrom: String
    @State var destinationTo: String
    
    var body: some View {
        VStack(spacing: 10){

            TextField("", text: self.$destinationFrom)
                .modifier(TextFieldModifier(startColor: .blue, endColor: .blue, textColor: .blue, placeHolderText: "From"))
            TextField("", text: self.$destinationTo)
                .modifier(TextFieldModifier(startColor: .green, endColor: .green, textColor: .green, placeHolderText: "To"))
            
            Button("Routes"){
                return
            }
            .buttonStyle(LargeButtonStyle())
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(WidgetBackgroundView(backgroundImage: Image("WidgetBackground"), cornerRadius: 0))
    }
}

struct TripPlannerWidget_Previews: PreviewProvider {
    static var previews: some View {
        TripPlannerWidget(destinationFrom: "", destinationTo: "")
    }
}
