//
//  Photo.swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/4/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let imageData: Data 
    let description: String
    let id: Int
    
   static func getIDForNewPhoto() -> Int {
        do {
            let photos = try PhotosPersistenceHelper.manager.getPhotos()
            let max = photos.map{$0.id}.max() ?? 0
            return max + 1
        } catch {
            print(error)
        }
        return 0
    }
}



