//
//  VideoCollectionViewCell.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import UIKit
import AVKit

protocol VideoDownloadedDelegate:class {
    func videoDownloaded(url:String)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playButtonImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var videoPlayer:AVPlayer?
    var videoLayer:AVPlayerLayer?
    var videoUrl = ""
    
    weak var delegate:VideoDownloadedDelegate?
    
    func setupVideoPlayer(url:String) {
        resetPlayerForReuse()
        let filevideoUrl = URL(string:url)!
        let assest = AVAsset(url:filevideoUrl)
        let playerItem = AVPlayerItem(asset:assest)
        videoPlayer =  AVPlayer(playerItem:playerItem)
        videoLayer = AVPlayerLayer(player:self.videoPlayer)
        videoLayer?.videoGravity = .resizeAspectFill
        videoLayer?.frame = self.bounds
        videoView.layer.addSublayer(self.videoLayer!)
        videoView.bringSubviewToFront(playButtonImageView)
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem, queue: .main) { [weak self] _ in
            self?.videoPlayer?.seek(to: CMTime.zero)
            self?.playVideo()
        }
    }
    
    override func layoutSubviews() {
        self.videoLayer?.frame = self.bounds
    }
    
    func pauseVideo() {
        videoPlayer?.pause()
    }
    
    func playVideo() {
        videoPlayer?.play()
        playButtonImageView.isHidden = true
    }
    
    func resetPlayerForReuse() {
        playButtonImageView.isHidden = true
        statusLabel.text = ""
        videoUrl = ""
        videoPlayer?.pause()
        playButtonImageView.isHidden = true
        activityIndicator.stopAnimating()
        videoLayer?.removeFromSuperlayer()
        videoPlayer =  nil
        if videoView.layer.sublayers?.isEmpty ?? false {
            videoView.layer.sublayers = nil
        }
    }
    
    override func prepareForReuse() {
        resetPlayerForReuse()
    }
    
    func applyTransformationEffect() {
        playButtonImageView.isHidden = false
        playButtonImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration:0.3, animations:{
           self.playButtonImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion:{ (completed) in
            
        })
    }
    
    func updatePauseState() {
        if videoPlayer?.timeControlStatus == AVPlayer.TimeControlStatus.playing {
            pauseVideo()
            applyTransformationEffect()
        }else {
            playVideo()
        }
    }
    
    
    func downloadVideo(url:String) {
        activityIndicator.startAnimating()
        videoUrl = url
        VideoTask.shared.getFileWith(stringUrl: url) { result in

            switch result {
            case .success(let path):
                  print("Downloaded video")
                  let validPath = path
                  self.setupVideoPlayer(url:validPath.absoluteString)
                  self.delegate?.videoDownloaded(url:url)
            case .failure(_):
                self.activityIndicator.stopAnimating()
                self.statusLabel.text = StringConstants.videoLoadFailed
                print("Failed to downloaded video")
            }
        }
    }
}
