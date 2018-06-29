//
//  HomeView.swift
//  imagePicker
//
//  Created by Caelan Dailey on 6/28/18.
//  Copyright © 2018 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject {
    func imageButtonPressed()
    func apiButtonPressed()
}

class HomeView: UIView {
    
    // Variables~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    weak var delegate: HomeViewDelegate?
    
    var imagePicker = UIImagePickerController()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Image Picker"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
  
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Caelan Dailey"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        return nameLabel
    }()

    
    let imageButton: UIButton = {
        let imageButton = UIButton()
        imageButton.setTitle("Get local image", for: .normal)
        imageButton.setTitleColor(.darkGray, for: .normal)
        imageButton.tintColor = .black
        return imageButton
    }()

    let apiButton: UIButton = {
        let apiButton = UIButton()
        apiButton.setTitle("Get unsplash image", for: .normal)
        apiButton.setTitleColor(.darkGray, for: .normal)
        apiButton.tintColor = .black
        return apiButton
    }()

    
    // Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    //ADD SUBVIEWS AND TARGETS
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 245/255, alpha: 1.0)
        
        // Labels
        addSubview(titleLabel)
        addSubview(nameLabel)


        // Buttons
        addSubview(imageButton)
        addSubview(apiButton)


        imageButton.addTarget(self, action: #selector(imageButtonPressed), for: .touchUpInside)
        apiButton.addTarget(self, action: #selector(apiButtonPressed), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        imageButton.frame = CGRect(x: 0, y: self.frame.height*5/10, width: self.frame.width, height: self.frame.height/10)
        apiButton.frame = CGRect(x: 0, y: self.frame.height*7/10, width: self.frame.width, height: self.frame.height/10)
        titleLabel.frame = CGRect(x: 0, y: self.frame.height*2/10, width: self.frame.width, height: self.frame.height/10)
        nameLabel.frame = CGRect(x: 0, y: self.frame.height*3/10, width: self.frame.width, height: self.frame.height/20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc
    func imageButtonPressed() {
        delegate?.imageButtonPressed()
    }
    
    @objc
    func apiButtonPressed() {
        delegate?.apiButtonPressed()
    }
}
