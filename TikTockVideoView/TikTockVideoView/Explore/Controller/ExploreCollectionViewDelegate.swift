//
//  ExploreCollectionViewDelegate.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit

extension ExploreViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.allCategories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier:CategoryTableViewCell.identifier, for:indexPath) as! CategoryTableViewCell
        categoryCell.categoryData = self.allCategories[indexPath.row]
        categoryCell.delegate = self
        return categoryCell
    }
}

extension ExploreViewController:SelectePostDelegate {
    func selectedVideo(category: Category, index: Int) {
        if let postVc = self.storyboard?.instantiateViewController(withIdentifier:PostDetailsViewController.identifier) as? PostDetailsViewController {
            postVc.category = category
            postVc.updateViewWithData(selectedIndex:index)
            self.navigationController?.pushViewController(postVc, animated:true)
        }
    }
}
