//
//  SecondViewController.swift
//  CrazyApp
//
//  Created by Sooi De Pauw on 04/01/2021.
//  Copyright © 2021 Sooi De Pauw. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import RealmSwift

class FavouritesGalleryViewController: UITableViewController {
    
    let headers: HTTPHeaders = [
        "x-api-key": "8eb84f83-3fbd-4d06-8bc8-e2a80f9350c1"
    ]
    
    var animals = [Animal]()
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.animals = Array(realm.objects(Animal.self).filter("favourite == true"))
    }
    
    // SOURCE: hackingwithswift.com
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Animal.self).filter("favourite == true").count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as! AnimalTableViewCell
        cell.animalLabel?.text = self.animals[indexPath.row].kind
        cell.animalImageView?.sd_setImage(with: URL(string: self.animals[indexPath.row].url), placeholderImage:UIImage(named: "placeholder"))
        return cell
    }
    
    
    let blogSegueIdentifier = "ShowDetailSegue"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == blogSegueIdentifier,
            let destination = segue.destination as? DetailViewController,
            let imageIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.selectedImage = self.animals[imageIndex].url
        }
    }
}


