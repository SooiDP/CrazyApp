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

class RandomImageViewController: UIViewController {

    let headers: HTTPHeaders = [
        "x-api-key": "8eb84f83-3fbd-4d06-8bc8-e2a80f9350c1"
    ]
    
    var myData:JSON?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getImgData()
    }
    
    func getImgData() {
        AF.request("https://api.thecatapi.com/v1/images/search", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json[0]["url"])")
            case .failure(let error):
                print(error)
            }
            
        }
    }


}

