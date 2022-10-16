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
    @ObservedObject var mapManager = MMapKitManager()
    @State var navigate: Bool = false
    
    var body: some View {
        if let leg = route?.legs?.first{
            ZStack{
                MapView(leg: leg, currentLocation: mapManager.currentLocation, navigate: $navigate)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .foregroundColor(.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                            if !navigate{
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                        }
                        .onTapGesture {
                            navigate.toggle()
                        }

                    }
                }
                .padding(20)
                
            }
        }
    }
    
}

struct MapView: UIViewRepresentable{
    typealias UIViewType = GMSMapView
    
    var leg: Leg
    var currentLocation: CLLocationCoordinate2D?
    @Binding var navigate: Bool
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: leg.startLocation!.lat!, longitude: leg.endLocation!.lng!, zoom: 10)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
       
        var polyline: GMSPolyline
        for step in leg.steps!{
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: step.endLocation!.lat!, longitude: step.endLocation!.lng!)
            
            switch step.travelMode{
            case .walking:
                marker.icon = UIImage(systemName: "figure.walk")
            case .transit:
                marker.icon = UIImage(systemName: "bus.fill")
            case .driving:
                break
            case .none:
                break
            }
            
            marker.map = mapView
            
            
            var path = GMSPath(fromEncodedPath: step.polyline!.points!)
            polyline = GMSPolyline(path: path)
            polyline.strokeColor = .blue
            polyline.strokeWidth = 2.0
            polyline.map = mapView
        }
        

        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if navigate{
            if let location = currentLocation{
                let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 14)
                uiView.camera = camera
                uiView.isMyLocationEnabled = true
                
            }
        } else {
            if let location = leg.endLocation{
                let camera = GMSCameraPosition.camera(withLatitude: location.lat!, longitude: location.lng!, zoom: 10)
                uiView.camera = camera
                uiView.isMyLocationEnabled = true
            }
        }
    }
    
}

struct TripMapView_Previews: PreviewProvider {
    static var previews: some View {
        TripMapView()
    }
}
