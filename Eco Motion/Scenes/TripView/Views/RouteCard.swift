//
//  RouteCard.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import SwiftUI

struct RouteCard: View {
    
    var route: Route
    var toText: String
    private let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Route 1")
                .font(.custom("Charter", size: 25)).bold()
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.gray)
            HStack{
                Text("Date:")
                    .font(.custom("Charter", size: 20))
                Spacer()
                Text("\(route.legs?.first?.arrivalTime?.text ?? "-")")
                    .font(.custom("Charter", size: 20)).bold()
            }
            HStack{
                Text("Duration:")
                    .font(.custom("Charter", size: 20))
                Spacer()
                Text("\(route.legs?.first?.duration?.text ?? "-")")
                    .font(.custom("Charter", size: 20)).bold()
            }
            
            VStack{
                
                if let legs = self.route.legs{
                    ForEach(legs, id: \.id){ leg in
                    LazyVGrid(  columns: [
                        // 3
                        GridItem(.flexible(minimum: 40, maximum: 120)),
                        GridItem(.flexible(minimum: 40, maximum: 120)),
                        GridItem(.flexible(minimum: 40, maximum: 120)),
                        // 4
                    ], alignment: .leading, spacing: 5){
                        if let steps = leg.steps {
                            ForEach(steps, id: \.id){ step in
                                HStack{
                                    
                                    if let mode = step.travelMode{
                                        switch mode{
                                        case .walking:
                                            Image(systemName: "figure.walk")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.blue)
                                        case .transit:
                                            Image(systemName: "bus.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.blue)
                                            
                                        }
                                    }
                                    VStack(alignment: .leading ,spacing: 0){
                                        Text(step.duration?.text ?? "-")
                                            .font(.custom("Charter", size: 20))
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .frame(width: 40, height: 20)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                    }
                }
            }
        }
            Spacer()
                .frame(height: 50)
            HStack{
                Text("\(route.co2 ?? -1) kg/\(route.legs?.first?.distance?.text?.contains("km") ?? true ? "km" : "mi")")
                    .font(.custom("Charter", size: 25)).bold()
                Spacer()
            }
        }
        .padding(20)
        .background(WidgetBackgroundView(backgroundColor: .white)
            .foregroundColor(.white))
    }
}
/*
 struct RouteCard_Previews: PreviewProvider {
 static var previews: some View {
 RouteCard(route: .init(destinations: [.init(type: .walk, duration: "5"), .init(type: .bus, duration: "10")], totalDuration: "15", emission: 10, date: "10-10-2022"), toText: "To")
 }
 }
*/
