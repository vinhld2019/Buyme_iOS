//
//  ImagePickerUtils.swift
//  Corporate
//
//  Created by Vinh LD on 5/29/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import AVFoundation

protocol ImagePickerUtilsDelegate: class {
    func imagePicker(didSelect image: UIImage)
}

class ImagePickerUtils: NSObject {
    
    static var shared: ImagePickerUtils { ImagePickerUtils() }
    
    weak var delegate: ImagePickerUtilsDelegate?
    
    override init() {
        super.init()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        chooseActionsViewController = UIAlertController(title: "Select an action".localize, message: "", preferredStyle: .actionSheet)
        let take = UIAlertAction(title: "Take a Photo".localize, style: .default) { _ in
            self.checkAccessCamera()
        }
        let library = UIAlertAction(title: "Open Library".localize, style: .default) { _ in
            self.showLibrary()
        }
        let cancel = UIAlertAction(title: "Cancel".localize, style: .cancel)
        
        chooseActionsViewController.addAction(take)
        chooseActionsViewController.addAction(library)
        chooseActionsViewController.addAction(cancel)
    }
    
    let imagePicker = UIImagePickerController()
    var chooseActionsViewController: UIAlertController!
    
    func show(delegate: ImagePickerUtilsDelegate? = nil) {
        self.delegate = delegate
        AppUtils.shared.present(chooseActionsViewController, animated: true)
    }

    func showLibrary() {
        imagePicker.sourceType = .photoLibrary
        AppUtils.shared.present(imagePicker, animated: true)
    }

    func showCamera() {
        imagePicker.sourceType = .camera
        AppUtils.shared.present(imagePicker, animated: true)
    }
    func checkAccessCamera() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            //already authorized
            self.showCamera()
        } else {
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.showCamera()
                } else {
                    let alert = UIAlertController(title: "APP_WANT_USE_CAMERA".localize, message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Go Setting".localize, style: .default) { _ in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    let cancel = UIAlertAction(title: "Cancel".localize, style: .destructive)
                    alert.addAction(okAction)
                    alert.addAction(cancel)
                    AppUtils.shared.present(alert, animated: true)
                }
            }
        }
    }
}

extension ImagePickerUtils: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.delegate?.imagePicker(didSelect: image)
        }
        imagePicker.dismiss(animated: true)
    }
}
