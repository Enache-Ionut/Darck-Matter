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
import UserNotifications

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var centerMapView: UIView!
    @IBOutlet weak var centerOnLocationImageView: UIImageView!
    @IBOutlet weak var showFiresOnMapSwitch: UISwitch!
    @IBOutlet weak var fireReportedView: UIView!
    @IBOutlet weak var fireReportedLabel: UILabel!
    
    var mapController: MapController?
    var locationManager = LocationManager()
    var networkManager = NetworkManager()
    var stubData = StubData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonView.layer.cornerRadius = 10
        buttonView.clipsToBounds = true
        
        fireReportedView.layer.cornerRadius = 10
        fireReportedView.clipsToBounds = true
        fireReportedView.alpha = 0.0
        fireReportedLabel.alpha = 0.0
        
        centerMapView.layer.cornerRadius = 25
        centerMapView.clipsToBounds = true
    
        let centerMapImage = UIImage(named: "target")
        centerOnLocationImageView.image = centerMapImage!
        
        self.mapController = MapController(mapView: mapView)
        locationManager.delegate = mapController
        mapController?.stubData = stubData
        
        mapController?.networkManager = networkManager
        networkManager.mapView = mapController
        networkManager.stubData = stubData
        
        // double tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.doubleTap(_:)))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 2
        centerMapView.addGestureRecognizer(tapGesture)
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
    
    func showFireReported() {
        UIView.animate(withDuration: 1.0, delay: 0.2, options:.curveEaseOut, animations: {
            self.fireReportedLabel.alpha = 1.0
            self.fireReportedView.alpha = 1.0
        }, completion: { _ in
            self.showFireReported2()
        })
    }
    
    func showFireReported2() {
        UIView.animate(withDuration: 1.0, delay: 1.0, options:.curveEaseIn, animations: {
            self.fireReportedLabel.alpha = 0.0
            self.fireReportedView.alpha = 0.0
        }, completion: { _ in
            self.mapController?.dropPinOnLocation()
        })

    }
    
    func scheduleNotification(timeInSeconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Fire Alert"
        content.body = "There is a fire near you, follow the escape route"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "demo", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @objc func doubleTap(_ gesture: UITapGestureRecognizer) {
        self.scheduleNotification(timeInSeconds: 5)
    }
    
    @IBAction func revealLocation(_ sender: UILongPressGestureRecognizer) {
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        mapController?.dropPinOnLocation(location: location)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ReportFireSegue") {
            if let destination = segue.destination as? PhotoViewController {
                destination.currentLocation = locationManager.currentLocation
                destination.networkManager = networkManager
                destination.previousController = self
            }
        }
    }
}
