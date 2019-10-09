//
//  PhotoCollectionViewCell.swift
//  PhotoJournalProject-Unit4
//
//  Created by Kary Martinez on 10/4/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var photoDescriptionLabel: UILabel!
    
    var buttonFunction: (()->Void)? //This is a closure. It doesn't have any specific return , so the return type (which is what the arrow means) is void.
    

    
    @IBAction func optionsButtonPressed(_ sender: Any) {
        if let closure = buttonFunction {
            closure()

        }
    }
       
}
