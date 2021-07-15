//
//  Animal.swift
//  CrazyApp
//
//  Created by Sooi De Pauw on 09/01/2021.
//  Copyright © 2021 Sooi De Pauw. All rights reserved.
//

import Foundation
import RealmSwift

class Animal: Object {
    @objc dynamic var url = ""
    @objc dynamic var kind = ""
    @objc dynamic var favourite = false
}
