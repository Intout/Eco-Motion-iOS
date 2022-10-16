//
//  MMapKitManager.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import Foundation
import MapKit
import CoreLocation
class MMapKitManager: NSObject, CLLocationManagerDelegate, ObservableObject{
    
    let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
       if manager.authorizationStatus == .authorizedWhenInUse{
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            DispatchQueue.main.async{
                self.currentLocation = .init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
    func fetchUserLocation() -> CLLocationCoordinate2D?{
        locationManager.location?.coordinate
    }
    
    func getSearch(text: String, completionHandler: @escaping (CLLocationCoordinate2D?, Error?) -> Void){
            if let coordinate = locationManager.location?.coordinate{
                let request = MKLocalSearch.Request()
                request.region = .init(center: coordinate, latitudinalMeters: .infinity, longitudinalMeters: .infinity)
                request.naturalLanguageQuery = text
                let search = MKLocalSearch(request: request)
                search.start{ response, error in
                    
                    if let item = response?.mapItems.first{
                        completionHandler(item.placemark.coordinate, nil)
                        return
                    }
                    
                    completionHandler(nil, error)
                    return
                }
                
            }
    }
    
    func searchByText(text: String, completionHandler: @escaping ([String]?, Error?) -> Void){
        if let coordinate = locationManager.location?.coordinate{
            let request = MKLocalSearch.Request()
            request.region = .init(center: coordinate, latitudinalMeters: .infinity, longitudinalMeters: .infinity)
            request.naturalLanguageQuery = text
            let search = MKLocalSearch(request: request)
            search.start{ response, error in
                
                if let items = response?.mapItems{
                    completionHandler(items.compactMap{
                        print($0.name)
                        return $0.name
                    }, nil)
                    return
                }
                
                completionHandler(nil, error)
                return
            }
            
        }
    }
    
}
