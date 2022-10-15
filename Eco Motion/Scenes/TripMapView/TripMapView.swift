//
//  TripMapView.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import SwiftUI
import MapKit
import CoreLocation
import GoogleMaps


struct TripMapView: View {
    
    var route: Route?
    
    var body: some View {
        if let leg = route?.legs?.first{
            MapView(leg: leg)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
}

struct MapView: UIViewRepresentable{
    typealias UIViewType = GMSMapView
    
    var leg: Leg
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: leg.startLocation!.lat!, longitude: leg.endLocation!.lng!, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
       
        
        var path = GMSPath(fromEncodedPath: leg.steps!.first!.polyline!.points!)
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .black
        polyline.strokeWidth = 10.0
        polyline.map = mapView
        
        /*
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        */
        
        
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
    }
    
}

struct TripMapView_Previews: PreviewProvider {
    static var previews: some View {
        TripMapView()
    }
}
