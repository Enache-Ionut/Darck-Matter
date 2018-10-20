//
//  ImagePickerManager.swift
//  SpotThatFire
//
//  Created by Radu Albastroiu on 20/10/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol ImagePickerManagerDelegate: class {
    func imageChosen(manager: ImagePickerManager, image: UIImage)
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let imagePickerController = UIImagePickerController()
    private let presentingController: UIViewController
    weak var delegate: ImagePickerManagerDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingController = presentingViewController
        super.init()
    }
    
    func presentPhotoPickerCamera(animated: Bool) {
        self.configureCamera()
        presentingController.present(imagePickerController, animated: animated, completion: nil)
    }
    
    func presentPhotoPickerLibrary(animated: Bool) {
        self.configureLibrary()
        presentingController.present(imagePickerController, animated: animated, completion: nil)
    }
    
    func dismissPhotoPicker(animated: Bool, completion: (() -> Void)?) {
        imagePickerController.dismiss(animated: animated, completion: completion)
    }
    
    private func configureCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.cameraDevice = .rear
        }
        
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        
        imagePickerController.delegate = self
    }
    
    private func configureLibrary() {
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        
        imagePickerController.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        delegate?.imageChosen(manager: self, image: image)
    }
}
