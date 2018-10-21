//
//  NetworkManager.swift
//  SpotThatFire
//
//  Created by Radu Albastroiu on 20/10/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkManager: NSObject {
    
    private var tempFireLocations = [CLLocation]()
    private var session: URLSession
    weak var mapView: MapController?
    weak var stubData: StubData?
    var urlFireLocations = URL(string: "http://192.168.0.118:80/darkmatter.json")
    
    override init() {
        self.session = URLSession(configuration: .default)
    }
    
    func upload(location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        print("uploaded: ")
        let slat = String(format:"%f", lat)
        let slon = String(format:"%f", lon)
        print("lat: " + slat + " lon: " + slon)
    }
    
    func getFireLocations(location: CLLocation, rangeInMeters: Double) {
        /*self.getFireLocations { (locations) in
            self.mapView?.showFiresAround(locations: locations)
        }
        */
        self.mapView?.addFires(locations: stubData!.getFireLocations())
        self.mapView?.showFiresAround()
    }
    
    private func getFireLocations(completitionHandler completion:@escaping ([CLLocation]) -> Void) {
        let request = URLRequest(url: urlFireLocations!)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion([])
                        return
                    }
                    
                    let status = httpResponse.statusCode
                    if(status == 200) {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                                let locations = json["data"] as? [Any] {
                                
                                var receivedLocations = [CLLocation]()
                                // for each location
                                for location in locations {
                                    
                                    // get location dict
                                    if let locationDict = location as? [String:Any],
                                    let latitude = locationDict["latitude"] as? Double,
                                    let longitude = locationDict["longitude"] as? Double {
                                        receivedLocations.append(CLLocation(latitude: CLLocationDegrees(exactly: latitude)!, longitude: CLLocationDegrees(exactly: longitude)!))
                                    }
                                }
                                
                                completion(receivedLocations)
                            }
                        } catch {
                            print("Error deserializing JSON: \(error)")
                        }
                        
                    } else {
                        completion([])
                    }
                } else {
                    completion([])
                }
            }
        }
        task.resume()
    }
}

