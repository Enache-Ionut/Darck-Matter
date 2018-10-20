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
    
    static func getFireLocations() -> [CLLocation] {
        var result = [CLLocation]()
        
        var location1 = CLLocation(latitude: CLLocationDegrees(exactly: 44.311)!, longitude: CLLocationDegrees(exactly: 23.819)!)
        var location2 = CLLocation(latitude: CLLocationDegrees(exactly: 44.316)!, longitude: CLLocationDegrees(exactly: 23.790)!)
        var location3 = CLLocation(latitude: CLLocationDegrees(exactly: 44.318)!, longitude: CLLocationDegrees(exactly: 23.798)!)
        
        result.append(location1)
        result.append(location2)
        result.append(location3)
        
        return result
    }
}
