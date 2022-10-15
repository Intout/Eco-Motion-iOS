//
//  TripView + ViewModel.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import Foundation
import MapKit
import CoreLocation

extension TripView{
    class ViewModel: ObservableObject{
        
        var searchText = ""
        private var networkModel = NetworkModel()
        private var fromCoordinate: CLLocationCoordinate2D?
        private var toCoordinate: CLLocationCoordinate2D?
        
        @Published var transitRoutes: [Route]?
        @Published var drivingRoutes: [Route]?
        @Published var walkingRoutes: [Route]?
        @Published var bicyclingRoutes: [Route]?
        
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
        
        
        private func fetchRoutes(fromCoordinate: CLLocationCoordinate2D, toCoordinate: CLLocationCoordinate2D){
            
            networkModel.getRoutesFromCoordinates(to: toCoordinate, from: fromCoordinate){ data, error in
                
                if let data = data{
                    if let routes = data.transit?.routes{
                        DispatchQueue.main.async {
                            self.transitRoutes = routes
                        }
                    }
                    if let routes = data.walking?.routes{
                        DispatchQueue.main.async {
                            self.walkingRoutes = routes
                        }
                    }
                    if let routes = data.driving?.routes{
                        DispatchQueue.main.async {
                            self.drivingRoutes = routes
                        }
                    }
                    if let routes = data.bicycling?.routes{
                        DispatchQueue.main.async {
                            self.bicyclingRoutes = routes
                        }
                    }
                }
                print(data)
                
            }
        }
        
    }
}
