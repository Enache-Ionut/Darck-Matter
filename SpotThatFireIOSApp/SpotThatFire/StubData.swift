//
//  StubData.swift
//  SpotThatFire
//
//  Created by Radu Albastroiu on 20/10/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import CoreLocation

class StubData {
    
    var data = [CLLocation]()
    
    init() {
        var location1 = CLLocation(latitude: CLLocationDegrees(exactly: 44.311)!, longitude: CLLocationDegrees(exactly: 23.819)!)
        var location2 = CLLocation(latitude: CLLocationDegrees(exactly: 44.316)!, longitude: CLLocationDegrees(exactly: 23.790)!)
        var location3 = CLLocation(latitude: CLLocationDegrees(exactly: 44.318)!, longitude: CLLocationDegrees(exactly: 23.798)!)
        
        data.append(location1)
        data.append(location2)
        data.append(location3)
    }
    
    func addFireLocation(location: CLLocation) {
        data.append(location)
    }
    
    func getFireLocations() -> [CLLocation] {
        return data
    }
}
