//
//  Post.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import Foundation

typealias CategoryDetails = [Category]

struct Category: Codable {
    let title: String
    let nodes: [Node]
}

// MARK: - Node
struct Node: Codable {
    let video: Video
}

// MARK: - Video
struct Video: Codable {
    let encodeURL: String
     let imageThumbNailUrl = "https://cdn.pixabay.com/photo/2020/02/14/04/20/old-city-4847469_1280.jpg"
    
    enum CodingKeys: String, CodingKey {
        case encodeURL = "encodeUrl"
    }
}
