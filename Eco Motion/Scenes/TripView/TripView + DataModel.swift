//
//  TripView + DataModel.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import Foundation
import MapKit

enum TripViewDataModel{
    
    struct Request{
        var fromCoordinates: CLLocationCoordinate2D
        var toCoordinates: CLLocationCoordinate2D
    }
    struct Response {
        var routes: [TripViewEntity.Route]
    }
    
    struct ViewModel{
        var fromText: String?
        var toText: String
        var routes: TripViewDataModel.Response?
    }
    
}
