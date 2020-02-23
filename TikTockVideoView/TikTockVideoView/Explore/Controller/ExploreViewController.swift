//
//  ExploreViewController.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    var allCategories = [Category]()
    var exploreVm = ExploreViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exploreVm.getCategoryDetails(completion: { [weak self] (categoryDetails) in
            DispatchQueue.main.async {
                self?.allCategories = categoryDetails
                self?.categoriesTableView.reloadData()
            }
        })
        
    }
    
    deinit {
        print("deallocated")
    }
}
