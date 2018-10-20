//
//  MapController.swift
//  SpotThatFire
//
//  Created by Radu Albastroiu on 20/10/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import MapKit

class MapController {
    
    private var mkMapView: MKMapView
    private var shouldCenterMapOnLocation: Bool
    private var currentLocation: CLLocation?
    private var fireAnnotations: [MKAnnotation]

    var pinPointFire = UIImage(named: "pinPoint")
    var showFiresOnMap: Bool
    var networkManager: NetworkManager?
    
    
    init(mapView: MKMapView) {
        self.fireAnnotations = [MKAnnotation]()
        self.showFiresOnMap = false
        self.mkMapView = mapView
        self.shouldCenterMapOnLocation = true
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsCompass = true
        mapView.showsScale = true
    }
    
    func centerMapOnLocation() {
        shouldCenterMapOnLocation = true
    }
    
    private func centerMapOn(location: CLLocation, withRadius radius: Double) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mkMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func requestFirestAround() {
        networkManager?.getFireLocations(location: currentLocation!, rangeInMeters: 2500)
    }
    
    func showFiresAround(locations: [CLLocation]) {
        if(showFiresOnMap) {
            for location in locations {
                let annotation = MKPointAnnotation()
                annotation.coordinate.latitude = location.coordinate.latitude
                annotation.coordinate.longitude = location.coordinate.longitude
                mkMapView.addAnnotation(annotation)
                fireAnnotations.append(annotation)
            }
        }
    }
    
    func removeFiresAround() {
        mkMapView.removeAnnotations(fireAnnotations)
        fireAnnotations.removeAll()
    }
}

extension MapController: LocationManagerDelegate {
    func locationUpdated(didUpdateLocations locations: [CLLocation]) {
        if(shouldCenterMapOnLocation) {
            if(locations.count > 0) {
                centerMapOn(location: locations[0], withRadius: 750)
                shouldCenterMapOnLocation = false
            }
        }
        currentLocation = locations[0]
    }
}
