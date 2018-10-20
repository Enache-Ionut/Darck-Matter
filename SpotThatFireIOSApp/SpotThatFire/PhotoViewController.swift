//
//  PhotoViewController.swift
//  SpotThatFire
//
//  Created by Radu Albastroiu on 20/10/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit
import CoreLocation

class PhotoViewController: UIViewController {

    @IBOutlet weak var imageChosenView: UIImageView!
    
    var currentLocation: CLLocation?
    var networkManager: NetworkManager?
    
    var imagePicker: ImagePickerManager?
    var viewFirstAppeared = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = ImagePickerManager(presentingViewController: self)
        imagePicker?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(viewFirstAppeared) {
            imagePicker?.presentPhotoPickerCamera(animated: true)
        }
        viewFirstAppeared = false
    }
    
    @IBAction func Dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func SendObservation(_ sender: Any) {
        let lat = currentLocation?.coordinate.latitude
        let lon = currentLocation?.coordinate.longitude
        
        if let networkMan = networkManager, let currLoc = currentLocation {
            networkMan.upload(location: currLoc)
        }
    }
    
}

extension PhotoViewController: ImagePickerManagerDelegate {
    func imageChosen(manager: ImagePickerManager, image: UIImage) {
        imageChosenView.image = image
        manager.dismissPhotoPicker(animated: true, completion: nil)
    }
}
