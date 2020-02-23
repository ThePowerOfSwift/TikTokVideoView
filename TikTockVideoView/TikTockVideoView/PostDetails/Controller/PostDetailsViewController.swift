//
//  PostDetailsViewController.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
   
    @IBOutlet weak var postsCollectionView: UICollectionView!
    var category:Category?
    var currentPlayerUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.postsCollectionView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func updateViewWithData(selectedIndex:Int) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.postsCollectionView.scrollToItem(at:IndexPath(item: selectedIndex, section: 0), at: .bottom, animated: false)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkForValidCellToPlay()
    }

    deinit {
        print("deallocated")
    }
}
