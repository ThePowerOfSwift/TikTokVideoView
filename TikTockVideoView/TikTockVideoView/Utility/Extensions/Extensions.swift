//
//  Extensions.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var identifier:String! {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var identifier:String! {
        return String(describing: self)
    }
}

extension UIViewController {
    static var identifier:String! {
        return String(describing: self)
    }
}
