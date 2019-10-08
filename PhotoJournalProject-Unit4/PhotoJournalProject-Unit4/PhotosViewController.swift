//
//  PhotosViewController.swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/4/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBAction func addPhotoButtonPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let addPhotoVC = storyboard.instantiateViewController(identifier: "AddPhotoVC") as EntryViewController
        
        present(addPhotoVC, animated: true, completion: nil)
        
    }
    

    
    
    var myPhotos = [Photo](){
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
    }
    
}



extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let specificPhoto = myPhotos[indexPath.row]
        
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
    
      
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}

