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

class GalleryViewController: UITableViewController {
    
    let headers: HTTPHeaders = [
        "x-api-key": "8eb84f83-3fbd-4d06-8bc8-e2a80f9350c1"
    ]
    
//    var animals = [Animal]()
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.animals = Array(realm.objects(Animal.self))
    }
    
    // SOURCE: hackingwithswift.com
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Animal.self).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "A very cute " + Array(realm.objects(Animal.self))[indexPath.row].kind
        cell.imageView?.sd_setImage(with: URL(string: Array(realm.objects(Animal.self))[indexPath.row].url), placeholderImage:UIImage(named: "placeholder"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = Array(realm.objects(Animal.self))[indexPath.row].url
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


