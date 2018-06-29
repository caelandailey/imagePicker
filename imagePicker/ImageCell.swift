//
//  ImageCell.swift
//  imagePicker
//
//  Created by Caelan Dailey on 6/28/18.
//  Copyright © 2018 Caelan Dailey. All rights reserved.
//
import UIKit

class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {

        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(imageView)
    }

}
