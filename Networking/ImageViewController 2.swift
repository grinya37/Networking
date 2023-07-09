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
    
    //private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let url = "https://oir.mobi/uploads/posts/2020-02/1582105523_66-p-neonovie-volki-83.jpg"
    private let largeImageUrl = "https://i.imgur.com/3416rvI.jpg"
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    
    func fetchImage() {
        
        NetworkManager.downloadImage(url: url) { (image) in
            
            self.imageView.image = image
        }
    }
    func fetchDataWithAlamofire() {
        
        AlamofireNetworkRequest.downloadImage(url: url) { (image) in
        
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    
    func downloadImageWithProgress() {
        
        AlamofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        
        AlamofireNetworkRequest.completed = { completed in
            self.completedLabel.isHidden = false
            self.completedLabel.text = completed
        }
        
        AlamofireNetworkRequest.downloadImageWithProgress(url: largeImageUrl) { (image) in
            
            self.activityIndicator.stopAnimating()
            self.completedLabel.isHidden = true
            self.progressView.isHidden = true
            self.imageView.image = image
        }
    }
}


