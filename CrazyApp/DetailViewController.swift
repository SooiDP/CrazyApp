//
//  SecondViewController.swift
//  CrazyApp
//
//  Created by Sooi De Pauw on 06/01/2021.
//  Copyright © 2021 Sooi De Pauw. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    let animalDb = AnimalPersistence()
    var delegate:AnimalDelegate?
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.sd_setImage(with: URL(string: imageToLoad), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }

    @IBAction func favourite(_ sender: Any) {
        self.delegate = animalDb
        self.delegate?.favouriteAnimal(selectedImage!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
}

