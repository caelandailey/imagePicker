//
//  ImagePickerModel.swift
//  imagePicker
//
//  Created by Caelan Dailey on 6/28/18.
//  Copyright © 2018 Caelan Dailey. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerModelDelegate: AnyObject {
    func loadedImages(_ images: [UIImage])
}

class ImagePickerModel {
    
    weak var delegate: ImagePickerModelDelegate? = nil
    
    var images: [UIImage] = [] {
        didSet{
            self.delegate?.loadedImages(self.images)
        }
    }
    
    var url: URL {
        let baseUrl = "https://api.unsplash.com/photos/"
        let client_id = "client_id=4505c852eecfde3c32a65491869576eda5f4a663c3c444f0a74bb642ebdb57c1"
        let paging = "per_page=25"
        let url = baseUrl + "?" + client_id + "&" + paging
        return URL(string: url)!
    }
    struct urls: Codable {
        let small: String
    }
    struct Image: Codable {
        let id: String
        let urls: urls
    }
    
    func loadImage() {
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        
        print(url)
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                
                return
            }
            
            let decoder = JSONDecoder()
            do {
                
                let images = try decoder.decode([Image].self, from: data)
                for image in images {
                    if let url = URL(string: image.urls.small ) {
                        self.downloadImage(url: url)
                    }
                }
                
            } catch {
                print("ERROR")
            }
        })
        task.resume()
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL)  {
        print("downloading image")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if let image = UIImage(data: data) {
                    self.images.append(image)
                    
                }
            }
        }
    }
}
