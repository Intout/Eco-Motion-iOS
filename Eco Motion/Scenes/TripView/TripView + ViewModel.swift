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
        
        @Published var routes: [TripViewEntity.Route]?
        var searchText = ""
        @Published var routes2: [Route]?
        private var networkModel = NetworkModel()
        private var fromCoordinate: CLLocationCoordinate2D?
        private var toCoordinate: CLLocationCoordinate2D?
        
        func viewDidLoad(){
            self.routes = [.init(destinations: [.init(type: .walk, duration: "5"), .init(type: .bus, duration: "10")], totalDuration: "15", emission: 10, date: "10-10-2022"), .init(destinations: [.init(type: .walk, duration: "2"), .init(type: .bus, duration: "10"), .init(type: .bus, duration: "5")], totalDuration: "17", emission: 25, date: "10-10-2022")]
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
            routes2
            networkModel.getRoutesFromCoordinates(to: toCoordinate, from: fromCoordinate){ data, error in
                
                if let data = data{
                    if let routes = data.routes{
                        DispatchQueue.main.async {
                            self.routes2 = routes
                        }
                        
                    }
                }
                print(data)
                
            }
        }
        
    }
}
