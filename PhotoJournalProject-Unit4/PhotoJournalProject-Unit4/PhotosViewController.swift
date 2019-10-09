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
        
        addPhotoVC.modalPresentationStyle = .fullScreen
        
        present(addPhotoVC, animated: true, completion: nil)
        
    }
    
    var myPhotos = [Photo](){
        didSet {
            self.photosCollectionView.reloadData()
        }
    }
    
    func deletePhoto(id: Int) {
        do {
            try PhotosPersistenceHelper.manager.deletePhoto(specificIDForPhotoIWantToDelete: id)
            //I deleted my photo. But the actual UI isn't reloading because myPhotos array hasn't yet been updated to show this.
        } catch {
            print(error)
        }
        loadData()
        //After I deleted my photo, I am now reloading my data by calling loadData(). This function gets all the photos from my .plist (which now no longer has the deleted photo), and sets it to the variable 'myPhotos'
        //Since 'myPhotos' has a property observer(didSet), it knows to reload the entire collection view whenever any thing inside myPhotos changes
    }
    
    func loadData(){
        do {
            myPhotos = try PhotosPersistenceHelper.manager.getPhotos() //I did something to myPhotos here. In this case, I put all the stuff from my saved photos in my .plist into the variable 'myPhotos'.
        } catch {
            print(error)
        }
    }
    
    func presentActionSheet(id: Int) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) in
            self.deletePhoto(id: id)
        })
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(editAction)
        actionSheet.addAction(deleteAction)
        
        present(actionSheet, animated: true, completion: nil) //This actually presents the actionSheet. Otherwise, it won't ever show.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        cell.cellImage.image = UIImage(data: specificPhoto.imageData)
        cell.photoDescriptionLabel.text = specificPhoto.description
        cell.buttonFunction = {self.presentActionSheet(id: specificPhoto.id)}
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 460)
    }
}

