//
//  AppImageDownloadManager.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit

class AppImageDownloadManager {
    static var imageDownloaderList = [String:ImageTask]()
    
    static func getImage(url:String) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: url as NSString){
            return cachedImage
        }
        return nil
    }
    
    static func createImageTask(url:String) -> ImageTask{
        if let task = AppImageDownloadManager.imageDownloaderList[url] {
            return task
        }
        let newTask = ImageTask(url:URL(string:url)!)
        AppImageDownloadManager.imageDownloaderList[url] = newTask
        return newTask
    }
}
