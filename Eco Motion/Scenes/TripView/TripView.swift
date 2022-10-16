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
    @State var selection: UUID?
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    DestinationWidget(fromText: fromText, toText: toText)
                        .padding([.horizontal], 20)
                    HStack{
                        Text("Routes")
                            .font(.custom("Charter", size: 30).bold())
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    VStack(alignment: .leading){
                        if let routes = self.viewModel.transitRoutes{
                            if routes.count != 0{
                                HStack{
                                    Text("Transit")
                                        .font(.custom("Charter", size: 25).bold())
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "bus.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.gray)
                                    
                                }
                                
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        ForEach(routes, id: \.id){ route in
                                            NavigationLink(destination: TripMapView(route: route), tag: route.id, selection: $selection){
                                                RouteCard(route: route, type: .transit ,toText: "")
                                                
                                                    .onTapGesture {
                                                        self.selection = route.id
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                            //.frame(minHeight: 50, maxHeight: 300)
                                            .frame(width: 300)
                                            Spacer()
                                                .frame(height: 20)
                                        }
                                    }
                                }
                                .frame(minHeight: 50, maxHeight: 300)
                            }
                        }
                        if let routes = self.viewModel.drivingRoutes{
                            if routes.count != 0{
                                HStack{
                                    Text("Driving")
                                        .font(.custom("Charter", size: 25).bold())
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "car.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.gray)
                                    
                                }
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        ForEach(routes, id: \.id){ route in
                                            NavigationLink(destination: TripMapView(route: route), tag: route.id, selection: $selection){
                                                RouteCard(route: route, type: .driving, toText: "")
                                                    .onTapGesture {
                                                        self.selection = route.id
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                            .frame(width: 300)
                                            Spacer()
                                                .frame(height: 20)
                                        }
                                    }
                                }
                                .frame(minHeight: 50, maxHeight: 300)
                            }
                        }
                        if let routes = self.viewModel.bicyclingRoutes  {
                            if routes.count != 0{
                                HStack{
                                    Text("Cycling")
                                        .font(.custom("Charter", size: 25).bold())
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "bicycle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.gray)
                                    
                                }
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        ForEach(routes, id: \.id){ route in
                                            NavigationLink(destination: TripMapView(route: route), tag: route.id, selection: $selection){
                                                RouteCard(route: route, type: .driving, toText: "")
                                                    .onTapGesture {
                                                        self.selection = route.id
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                            
                                            .frame(width: 300)
                                            Spacer()
                                                .frame(height: 20)
                                        }
                                    }
                                }
                                .frame(minHeight: 50, maxHeight: 300)
                            }
                        }
                        if let routes = self.viewModel.walkingRoutes{
                            if routes.count != 0{
                                HStack{
                                    Text("Walking")
                                        .font(.custom("Charter", size: 25).bold())
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "figure.walk")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.gray)
                                    
                                }
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack{
                                        ForEach(routes, id: \.id){ route in
                                            NavigationLink(destination: TripMapView(route: route), tag: route.id, selection: $selection){
                                                RouteCard(route: route, type: .walking, toText: "")
                                                    .onTapGesture {
                                                        
                                                        self.selection = route.id
                                                    }
                                            }
                                            .buttonStyle(.plain)
                                            .frame(width: 300)
                                            Spacer()
                                                .frame(height: 20)
                                        }
                                    }
                                }
                                .frame(minHeight: 50, maxHeight: 300)
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
