//
//  ImagePickerViewController.swift
//  imagePicker
//
//  Created by Caelan Dailey on 6/28/18.
//  Copyright © 2018 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerViewController: UIViewController, ImagePickerModelDelegate {
    
    func loadedImages(_ images: [UIImage]) {
        collectionView.images = images
    }
    
    let imageModel = ImagePickerModel()
    
    private var collectionView: ImagePickerCollectionView {
        return view as! ImagePickerCollectionView
    }
    
    // Loads the view
    override func loadView() {
        super.loadView()
 
        let layout = UICollectionViewFlowLayout()
        
        let itemInset:CGFloat = 3
        let numberOfSectionItems = 4
        
        layout.sectionInset = UIEdgeInsets(top: itemInset, left: itemInset, bottom: 0, right: itemInset)
        let itemHeight = (self.view.frame.width-itemInset)/CGFloat(numberOfSectionItems)
        let itemWidth = (self.view.frame.width-itemInset*(CGFloat(numberOfSectionItems)+1))/CGFloat(numberOfSectionItems)
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemInset
        layout.scrollDirection = .vertical
        


        let myCollectionView = ImagePickerCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = myCollectionView
        myCollectionView.delegate = myCollectionView
        myCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.white
        view = myCollectionView
        
        print("Loaded view")
    }
    
 
    @objc
    func backButton() {
        print("here")
        var imagesArray: [UIImage] = []
        for pos in collectionView.selectedImages {
            imagesArray.append(collectionView.images[pos.row + (pos.section*collectionView.itemsPerSection)])
        }
        (navigationController?.viewControllers.first as! HomeViewController).images = imagesArray
        self.navigationController?.popViewController(animated: true)
    }
    
    // Create button
    var selectionButton : UIBarButtonItem = {
        let selectionButton = UIBarButtonItem()
        selectionButton.title = "Preview Mode"
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        var styles: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): style]
        styles[NSAttributedStringKey.font] = UIFont(name: "HelveticaNeue-Medium", size: 15 )
        
        // Create and draw
        selectionButton.setTitleTextAttributes(styles, for: UIControlState.normal)
        
        selectionButton.action = #selector(changeViewMode)
        
        
        return selectionButton
    }()
    
    
    @objc func changeViewMode() {
        print("here")
        collectionView.isPreviewMode = !collectionView.isPreviewMode
        
        if (collectionView.isPreviewMode) {
            selectionButton.title = "Preview Mode"
        } else {
            selectionButton.title = "Selection Mode"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageModel.delegate = self
        imageModel.loadImage()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButton))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        self.navigationItem.rightBarButtonItem = selectionButton
        selectionButton.target = self
    }
    
    
}
