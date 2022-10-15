//
//  TripView + NetworkModel.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import Foundation
import MapKit

enum DataModelError: Error{
    case invalidData
}

extension TripView{
    class NetworkModel{
        
        func getRoutesFromCoordinates(to: CLLocationCoordinate2D, from: CLLocationCoordinate2D, completionHandler: @escaping (TripModel?, Error?) -> Void){
            
            guard let url = URL(string: "https://eco-motion.azurewebsites.net/api/maps?origin=\(Float(to.latitude)),\(Float(to.longitude))&destination=\(Float(from.latitude)),\(Float(from.longitude))&mode=transit&alternatives=true") else {
                completionHandler(nil, URLError.badURL as? Error)
                return
            }
            print("https://eco-motion.azurewebsites.net/api/maps?origin=\(Float(to.latitude)),\(Float(to.longitude))&destination=\(Float(from.latitude)),\(Float(from.longitude))&mode=transit&alternatives=true")
            var request = URLRequest(url: url)
            request.httpMethod = "GET_TRANSIT"
            let task = URLSession.shared.dataTask(with: request){ data, response, error in
                
                guard let data = data, (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completionHandler(nil, error)
                    print("Couldn't fetch API data!")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(TripModel.self, from: data)
                    
                        completionHandler(jsonData, nil)
                        return

                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                

                
            }
            task.resume()
            
        }
        
    }
}
