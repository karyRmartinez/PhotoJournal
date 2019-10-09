//
//  ViewController.swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/3/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var EditingImage: UIImageView!
    
    
    @IBAction func SaveButton(_ sender: UIButton) {
        savedPhotos()
    }
    var photoLibraryAccess = false
    
    var image = UIImage() {
        didSet {
            EditingImage.image = image
        }
    }
    
    
    func savedPhotos(){
        guard let image = EditingImage.image else { return}
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        guard let descriptionText = descriptionTextView.text else { return }
        
        let newPhoto = Photo(imageData: imageData, description: descriptionText, id: Photo.getIDForNewPhoto())
        
        do {
            try? PhotosPersistenceHelper.manager.savePhoto(photo: newPhoto)
        }
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = "Enter Text here"
        descriptionTextView.textColor = UIColor.black
        descriptionTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter Text here" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func photoLibraryAccess(_ sender: UIBarButtonItem) {
        
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.sourceType = .photoLibrary
        
        if photoLibraryAccess{
            imagePickerViewController.delegate = self
            present(imagePickerViewController, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "No Access", message: "Photo access is required to use this app.", preferredStyle: .alert)
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
        }
    }
    
}



extension EntryViewController: UITextViewDelegate {
    
    
}
