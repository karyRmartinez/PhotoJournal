//
//  ViewController.swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/3/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var EditingTextView: UITextView!
    
    var photoLibraryAccess = false
    
    @IBOutlet weak var EditingImage: UIImageView!
    
    var image = UIImage() {
        didSet {
            EditingImage.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
                  
                  alertVC.addAction(UIAlertAction (title: "I will let you in", style: .default, handler: { (action) in
                      self.photoLibraryAccess = true
                      self.present(imagePickerViewController, animated: true, completion: nil)
                  }))
              }
          }
    
}

extension EntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image :(
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
