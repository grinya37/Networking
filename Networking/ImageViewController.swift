//
//  ImageViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 27.07.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {
    
    private let url = "https://oir.mobi/uploads/posts/2020-02/1582105523_66-p-neonovie-volki-83.jpg"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.downloadImage(url: url) { (image) in
            
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    func fetchDataWithAlamofire() {
        request(url).responseData { (responseData) in
            switch responseData.result {
                case.success(let data):
                
                guard let image = UIImage(data: data) else { return }
                
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
