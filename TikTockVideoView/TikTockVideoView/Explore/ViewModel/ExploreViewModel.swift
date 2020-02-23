//
//  ExploreViewModel.swift
//  TikTockVideoView
//
//  Created by Dinesh on 2/22/20.
//  Copyright © 2020 DINESH GUPTHA. All rights reserved.
//

import Foundation

class ExploreViewModel {
    
    func getCategoryDetails(completion: @escaping ([Category]) -> ()) {
        if let url = Bundle.main.url(forResource: AssignmentDetails.fileName, withExtension: AssignmentDetails.fileType) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Category].self, from: data)
                 completion(jsonData)
            } catch {
                completion([Category]())
                print("error:\(error)")
            }
        }else{
            completion([Category]())
        }
    }
    
}
