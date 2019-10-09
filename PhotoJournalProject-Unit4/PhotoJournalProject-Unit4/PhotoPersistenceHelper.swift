//
//  File.swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/7/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import Foundation

struct PhotosPersistenceHelper {
    
    private init() {}
    
    static let manager = PhotosPersistenceHelper()
    
    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "allphotodxsads.plist")
    
    func savePhoto(photo: Photo) throws {
        try persistenceHelper.save(newElement: photo)
    }
    func getPhotos() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }
    
    func deletePhoto(specificIDForPhotoIWantToDelete: Int) throws {
        //We want to make a new array that has all the photos from the previous array EXCEPT for the photo that has the ID we want to delete.
        
        do {
            let photosArray = try getPhotos()
            //First, get all of my photos in my .plist and save them to 'photos' constant.
            
            var newPhotosArray = [Photo]()
            
            //Now, we iterate through each individual photo in photoArray
            for photo in photosArray {
                if photo.id == specificIDForPhotoIWantToDelete {
                    continue
                    //If, as we iterate, we find that the photo has the ID that matches the one we want to delete, we skip over it.
                } else {
                    newPhotosArray.append(photo)
                    //We append all the other photos that DON'T have the ID we want to delete, to our newPhotosArray.
                }
            }
            
            try persistenceHelper.replace(elements: newPhotosArray)
            //Now that we have this new array that excludes the photo we want to delete, we are going to overwrite the previous array with this new one.
        }
    }
}
