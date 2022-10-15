//
//  TripView.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import SwiftUI

struct TripView: View {
    
    var fromText: String?
    var toText: String
    
   @ObservedObject var viewModel = ViewModel()
    @State var routes: [Route]?
    @State var selection: Int?
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack(alignment: .leading, spacing: 60){
                    DestinationWidget(fromText: fromText, toText: toText)
                        .padding(20)
                    VStack{
                        HStack{
                            Text("Routes")
                                .font(.custom("Charter", size: 30).bold())
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        if let routes = self.viewModel.routes2{
                            ForEach(routes, id: \.id){ route in
                                NavigationLink(destination: TripMapView(route: route), tag: 2, selection: $selection){
                                    RouteCard(route: route, toText: "")
                                        .onTapGesture {
                                            self.selection = 2
                                        }
                                }
                                Spacer()
                                    .frame(height: 20)
                            }
                        }
                        
                        
                    }
                    .padding([.horizontal, .top], 20)
                    .background(WidgetBackgroundView())
                }
                
            }
        }
        .background(Color(red: 0.972, green: 1, blue: 0.958))
        .onAppear{
            self.viewModel.searchText = toText
            self.viewModel.viewDidLoad()
        }

    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(toText: "Paris")
    }
}
