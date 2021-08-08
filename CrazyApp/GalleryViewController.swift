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

class AnimalTableViewCell: UITableViewCell {
    @IBOutlet var animalLabel: UILabel!
    @IBOutlet var animalImageView: UIImageView!
}

class GalleryViewController: UITableViewController {
    let headers: HTTPHeaders = [
        "x-api-key": "8eb84f83-3fbd-4d06-8bc8-e2a80f9350c1"
    ]
    
    let realm = try! Realm()
    var animals = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    // SOURCE: hackingwithswift.com
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let id = self.navigationController!.restorationIdentifier
        if (id == "favouritesController") {
            return realm.objects(Animal.self).filter("favourite = true").count
        }
        return realm.objects(Animal.self).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = self.navigationController!.restorationIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as! AnimalTableViewCell
        if (id == "favouritesController") {
            cell.animalLabel?.text = Array(realm.objects(Animal.self).filter("favourite = true"))[indexPath.row].kind
            cell.animalImageView?.sd_setImage(with: URL(string: Array(realm.objects(Animal.self).filter("favourite = true"))[indexPath.row].url), placeholderImage:UIImage(named: "placeholder"))
            return cell
        }
        cell.animalLabel?.text = Array(realm.objects(Animal.self))[indexPath.row].kind
        cell.animalImageView?.sd_setImage(with: URL(string: Array(realm.objects(Animal.self))[indexPath.row].url), placeholderImage:UIImage(named: "placeholder"))
        return cell
    }
    
    
    let SegueIdentifier = "ShowDetailSegue"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = self.navigationController!.restorationIdentifier
        if  segue.identifier == SegueIdentifier,
            let destination = segue.destination as? DetailViewController,
            let imageIndex = tableView.indexPathForSelectedRow?.row
        {
            if (id == "favouritesController") {
                destination.selectedImage = Array(realm.objects(Animal.self).filter("favourite = true"))[imageIndex].url
            } else {
                destination.selectedImage = Array(realm.objects(Animal.self))[imageIndex].url
            }
        }
    }
    
    @objc func refresh() {
        self.tableView.reloadData()
    }
}


