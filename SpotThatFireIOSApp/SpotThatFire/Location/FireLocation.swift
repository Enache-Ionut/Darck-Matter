//
//  FireLocation.swift
//  SpotThatFire
//
//  Created by Radu Albastroiu on 20/10/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import CoreLocation

class FireLocation {
    
    var fireLocations: [CLLocation]
    
    init() {
        fireLocations = []
    }
    
    func changeFireLocations(locations: [CLLocation]) {
        fireLocations = locations
    }
}
