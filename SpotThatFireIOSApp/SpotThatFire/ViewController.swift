//
//  ViewController.swift
//  SpotThatFire
//
//  Created by Radu Albastroiu on 20/10/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var centerMapView: UIView!
    @IBOutlet weak var centerOnLocationImageView: UIImageView!
    @IBOutlet weak var showFiresOnMapSwitch: UISwitch!
    
    var mapController: MapController?
    var locationManager = LocationManager()
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonView.layer.cornerRadius = 10
        buttonView.clipsToBounds = true
        
        centerMapView.layer.cornerRadius = 25
        centerMapView.clipsToBounds = true
        
        let centerMapImage = UIImage(named: "target")
        centerOnLocationImageView.image = centerMapImage!
        
        self.mapController = MapController(mapView: mapView)
        locationManager.delegate = mapController
        
        mapController?.networkManager = networkManager
        networkManager.mapView = mapController
    }
    
    @IBAction func centerMapOnLocation(_ sender: Any) {
        if let mapCtrl = mapController {
            mapCtrl.centerMapOnLocation()
        }
    }
    
    @IBAction func showFiresOnMap(_ sender: Any) {
        if(showFiresOnMapSwitch.isOn) {
            mapController?.showFiresOnMap = true
            mapController?.requestFirestAround()
        } else {
            mapController?.showFiresOnMap = false
            mapController?.removeFiresAround()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ReportFireSegue") {
            if let destination = segue.destination as? PhotoViewController {
                destination.currentLocation = locationManager.currentLocation
                destination.networkManager = networkManager
            }
        }
    }
}
