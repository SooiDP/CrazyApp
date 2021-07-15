//
//  FirstViewController.swift
//  CrazyApp
//
//  Created by Sooi De Pauw on 04/01/2021.
//  Copyright © 2021 Sooi De Pauw. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import RealmSwift

class RandomImageViewController: UIViewController {
    
    let animalDb = AnimalPersistence()

    let headers: HTTPHeaders = [
        "x-api-key": "8eb84f83-3fbd-4d06-8bc8-e2a80f9350c1"
    ]
    
    var delegate:AnimalDelegate?
    
    var myData:String?
    
//    let config = Realm.Configuration(
//        schemaVersion: 5,
//        migrationBlock: { migration, oldSchemaVersion in
//            if(oldSchemaVersion < 5) {
//                migration.enumerateObjects(ofType: Animal.className()) { oldObject, newObject in
//                    newObject!["favourite"] = false
//                }
//            }
//    })
//
//    Realm.Configuration.defaultConfiguration = config

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fetchCatImage() {
        getImgData(kind: "cat")
    }
    
    @IBAction func fetchRandomImage() {
        let number = Int.random(in: 0..<10)
        var kind:String
        if (number < 5) {
            kind = "cat"
        } else {
            kind = "dog"
        }
        getImgData(kind: kind)
    }
    
    @IBAction func fetchDogImage() {
        getImgData(kind: "dog")
    }
    
    func getUrl(kind: String) -> String {
        if (kind == "dog") {
            return "https://api.thedogapi.com/v1/images/search"
        }
        return "https://api.thecatapi.com/v1/images/search"
    }
    
    func getImgData(kind: String) {
        self.delegate = animalDb
        let url = getUrl(kind: kind)
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let animal = Animal()
                let json = JSON(value)
                self.myData = json[0]["url"].string
                animal.url = json[0]["url"].string ?? ""
                animal.kind = kind
                self.delegate?.saveAnimal(animal)
                self.imageView.sd_setImage(with: URL(string: animal.url), placeholderImage: UIImage(named: "placeholder.png"))
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

