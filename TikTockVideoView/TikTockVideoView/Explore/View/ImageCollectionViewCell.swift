//
//  ImageCollectionViewCell.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit

protocol ImageViewUpdatedDelegate:class {
    func imageUpdated()
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: DownloadImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func prepareForReuse() {
        self.thumbnailImageView.makeImageViewReusable()
        self.activityIndicator.stopAnimating()
    }
 
    func loadImage(url:String) {
        if let _ = URL(string:url) {
            self.activityIndicator.startAnimating()
            self.thumbnailImageView.delegate =  self
            self.thumbnailImageView.loadImageForUrl(url:url)
        }
    }
}

extension ImageCollectionViewCell:ImageViewUpdatedDelegate {
    func imageUpdated() {
        self.activityIndicator.stopAnimating()
    }
}


class DownloadImageView:UIImageView {
    var imageURL:String?
    var imageTask:ImageTask?
    var delegate:ImageViewUpdatedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func set(image: UIImage?) {
        self.image = image
        self.delegate?.imageUpdated()
    }
    
    func makeImageViewReusable() {
        self.imageTask?.pause()
        self.imageURL = ""
        self.image = nil
        self.delegate = nil
    }
    
    func loadImageForUrl(url:String) {
        imageURL = url
        if let hasImage = AppImageDownloadManager.getImage(url:url) {
            self.set(image:hasImage)
        }else {
            imageTask = AppImageDownloadManager.createImageTask(url:url)
            imageTask?.observers.append(self)
            imageTask?.resume()
        }
    }
}

extension DownloadImageView:ImageTaskDownloadedDelegate {
    func imageDownloaded(url: String, image: UIImage) {
        if self.imageURL == url {
            self.set(image:image)
        }
    }
    
    func failedDownload(url: String){
        if self.imageURL == url {
            self.delegate?.imageUpdated()
        }
    }
}
