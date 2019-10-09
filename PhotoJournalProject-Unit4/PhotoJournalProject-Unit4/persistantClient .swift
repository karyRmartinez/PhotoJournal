//
//  persistantClient .swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/4/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import Foundation

struct ImagePersistence {
    private init() {}
    
    static let manager = ImagePersistence()
    
    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "allPhotos.plist")
    
    func saveProfileImage(info: Photo) throws {
        try persistenceHelper.saveSingleObject(newElement: info)
    }
    
  func getPhotos() throws -> [Photo] {
      return try persistenceHelper.getObjects()
  }
    
    
}



