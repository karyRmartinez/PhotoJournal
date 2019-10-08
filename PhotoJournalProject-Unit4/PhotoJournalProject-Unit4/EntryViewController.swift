//
//  ViewController.swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/3/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {


    @IBOutlet weak var textView: UITextView!
   
    var photoLibraryAccess = false
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var EditingImage: UIImageView!
    
    var image = UIImage() {
        didSet {
            EditingImage.image = image
        }
    }
    @IBAction func SaveButton(_ sender: UIButton) {
        savedPhotos()
        
    }
    
    
    func savedPhotos(){
   
        guard let image = EditingImage.image else { return}
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
       

            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }

    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        
       
    }


    @IBAction func photoLibraryAccess(_ sender: UIBarButtonItem) {
        
        let imagePickerViewController = UIImagePickerController()
              imagePickerViewController.delegate = self
              imagePickerViewController.sourceType = .photoLibrary
              
              if photoLibraryAccess{
                  imagePickerViewController.delegate = self
                  present(imagePickerViewController, animated: true, completion: nil)
              } else {
                  let alertVC = UIAlertController(title: "No Access", message: "Camera access is required to use this app.", preferredStyle: .alert)
                  alertVC.addAction(UIAlertAction (title: "Deny", style: .destructive, handler: nil))
                  self.present(alertVC, animated: true, completion: nil)
                  
                  alertVC.addAction(UIAlertAction (title: "Allowed", style: .default, handler: { (action) in
                      self.photoLibraryAccess = true
                      self.present(imagePickerViewController, animated: true, completion: nil)
                  }))
              }
          }
    
}

extension EntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            EditingImage.image = image
        } else {
            print("original image is nil")
        }
        dismiss(animated: true) {
            //save to File Manager
            guard let imageData = self.EditingImage.image?.jpegData(compressionQuality: 0.5) else {return}
            
            let ImageInfo = Photo(imageData: imageData)
             try? ImagePersistence.manager.saveProfileImage(info: ImageInfo)
        }
    }
    
}



extension EntryViewController: UITextViewDelegate {
  
}
