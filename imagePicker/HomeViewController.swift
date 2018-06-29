//
//  HomeViewController.swift
//  imagePicker
//
//  Created by Caelan Dailey on 6/28/18.
//  Copyright © 2018 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, HomeViewDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    var images: [UIImage] = [] {
        didSet{
            print("Passed images to caller")
        }
    }
    
    private var viewHolder: HomeView {
        return view as! HomeView
    }

    // Loads the view
    override func loadView() {
        view = HomeView()
    }
    
    func imageButtonPressed() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func apiButtonPressed() {
       navigationController?.pushViewController(ImagePickerViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        viewHolder.delegate = self
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let testView = UIImageView(image: chosenImage)
        testView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.view.addSubview(testView)
        
        dismiss(animated: true, completion: nil)
    }
}
