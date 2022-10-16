//
//  TripView + ViewModel.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

struct RouteModel: Identifiable{
    var id = UUID()
    var route: Route
    var name: String
    var color: Color
    var type: TravelMode
}

extension TripView{
    class ViewModel: ObservableObject{
        
        var searchText = ""
        private var networkModel = NetworkModel()
        private var fromCoordinate: CLLocationCoordinate2D?
        private var toCoordinate: CLLocationCoordinate2D?
        
        @Published var transitRoutes: [RouteModel]?
        @Published var drivingRoutes: [RouteModel]?
        @Published var walkingRoutes: [RouteModel]?
        @Published var bicyclingRoutes: [RouteModel]?
        
        func viewDidLoad(){
            MMapKitManager().getSearch(text: searchText){ data, error in
                if let data = data{
                    print("Data: \(data)")
                    if let location = MMapKitManager().fetchUserLocation(){
                        self.fetchRoutes(fromCoordinate: location, toCoordinate: data)
                    }
                }
            }
            
        }
        
        
        private func distributeColor(array: [Route]) -> [Float: Color]{
            
            var dict: [Float: Color] = [:]
            var colorArray = Array(Set(array.compactMap{
                $0.co2
            }))
            colorArray = colorArray.sorted{
                $0 < $1
            }
            
            for (index ,color) in colorArray.enumerated(){
                dict[color] = Color(red: Double(1-(1/(index+1))), green: Double(1/(index+1)), blue: 92/255)
            }
            return dict
        }
        
        private func fetchRoutes(fromCoordinate: CLLocationCoordinate2D, toCoordinate: CLLocationCoordinate2D){
            
            networkModel.getRoutesFromCoordinates(to: toCoordinate, from: fromCoordinate){[weak self] data, error in
                
                if let data = data{
                    if let routes = data.transit?.routes{
                        
                        var colorArray = self?.distributeColor(array: routes)
                        
                        var model: [RouteModel] = []
                        
                        for (index, route) in routes.enumerated() {
                            model.append(.init(route: route, name: "Transit \(index+1)", color: colorArray?[route.co2!] ?? .gray, type: .transit))
                        }
                        
                        DispatchQueue.main.async {
                            
                            self?.transitRoutes = model
                        }
                    }
                    if let routes = data.walking?.routes{
                        
                        var colorArray = self?.distributeColor(array: routes)
                        
                        var model: [RouteModel] = []
                        
                        for (index, route) in routes.enumerated() {
                            model.append(.init(route: route, name: "Walking \(index+1)", color: colorArray?[route.co2!] ?? .gray, type: .walking))
                        }
                        
                        DispatchQueue.main.async {
                            self?.walkingRoutes = model
                        }
                    }
                    if let routes = data.driving?.routes{
                        
                        var colorArray = self?.distributeColor(array: routes)
                        
                        var model: [RouteModel] = []
                        
                        for (index, route) in routes.enumerated() {
                            model.append(.init(route: route, name: "Driving \(index+1)", color: colorArray?[route.co2!] ?? .gray, type: .driving))
                        }
                        
                        DispatchQueue.main.async {
                            self?.drivingRoutes = model
                        }
                    }
                    if let routes = data.bicycling?.routes{
                        
                        var colorArray = self?.distributeColor(array: routes)
                        
                        var model: [RouteModel] = []
                        
                        for (index, route) in routes.enumerated() {
                            model.append(.init(route: route, name: "Cycling \(index+1)", color: colorArray?[route.co2!] ?? .gray, type: .cycling))
                        }
                        
                        DispatchQueue.main.async {
                            self?.bicyclingRoutes = model
                        }
                    }
                }
                print(data)
                
            }
        }
        
    }
}
