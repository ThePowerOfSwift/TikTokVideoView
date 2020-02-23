//
//  PostDetailCollectionViewDelegate.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit

extension PostDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.nodes.count ?? 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkForValidCellToPlay()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            checkForValidCellToPlay()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier:VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        print("create video cell at :\(indexPath.row)")
        if let videoUrl = category?.nodes[indexPath.row].video.encodeURL {
            videoCell.downloadVideo(url:videoUrl)
            videoCell.delegate = self
        }
        return videoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let videoCell = collectionView.cellForItem(at:indexPath) as? VideoCollectionViewCell {
            videoCell.updatePauseState()
        }
        print("play/pause video")
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoCollectionViewCell {
            videoCell.pauseVideo()
        }
        print("pause video at :\(indexPath.row)")
    }
    
    func checkForValidCellToPlay() {
        let allVisibleCells = postsCollectionView.visibleCells
        for cell in allVisibleCells {
            if let videoCell = cell as? VideoCollectionViewCell {
                currentPlayerUrl = videoCell.videoUrl
                videoCell.playVideo()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.width, height:collectionView.frame.size.height)
    }
    
}

extension PostDetailsViewController:VideoDownloadedDelegate {
    func videoDownloaded(url: String) {
        if url == currentPlayerUrl {
            self.checkForValidCellToPlay()
        }
    }
}
