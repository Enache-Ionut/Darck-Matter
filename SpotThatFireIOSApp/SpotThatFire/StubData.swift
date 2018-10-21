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
        let location1 = CLLocation(latitude: CLLocationDegrees(exactly: 43.999)!, longitude: CLLocationDegrees(exactly: 24.269)!)
        let location2 = CLLocation(latitude: CLLocationDegrees(exactly: 44.590)!, longitude: CLLocationDegrees(exactly: 25.292)!)
        let location3 = CLLocation(latitude: CLLocationDegrees(exactly: 43.576)!, longitude: CLLocationDegrees(exactly: 23.704)!)
        let location4 = CLLocation(latitude: CLLocationDegrees(exactly: 43.580)!, longitude: CLLocationDegrees(exactly: 24.988)!)
        let location5 = CLLocation(latitude: CLLocationDegrees(exactly: 44.212)!, longitude: CLLocationDegrees(exactly: 22.213)!)
        let location6 = CLLocation(latitude: CLLocationDegrees(exactly: 45.054)!, longitude: CLLocationDegrees(exactly: 21.601)!)
        let location7 = CLLocation(latitude: CLLocationDegrees(exactly: 46.106)!, longitude: CLLocationDegrees(exactly: 23.210)!)
        let location8 = CLLocation(latitude: CLLocationDegrees(exactly: 46.473)!, longitude: CLLocationDegrees(exactly: 25.338)!)
        let location9 = CLLocation(latitude: CLLocationDegrees(exactly: 42.838)!, longitude: CLLocationDegrees(exactly: 22.998)!)
        let location10 = CLLocation(latitude: CLLocationDegrees(exactly: 43.445)!, longitude: CLLocationDegrees(exactly: 22.327)!)
        
        data.append(location1)
        data.append(location2)
        data.append(location3)
        data.append(location4)
        data.append(location5)
        data.append(location6)
        data.append(location7)
        data.append(location8)
        data.append(location9)
        data.append(location10)
    }
    
    func addFireLocation(location: CLLocation) {
        data.append(location)
    }
    
    func getFireLocations() -> [CLLocation] {
        return data
    }
}
