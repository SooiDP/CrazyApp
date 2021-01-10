//
//  AnimalSaver.swift
//  CrazyApp
//
//  Created by Sooi De Pauw on 10/01/2021.
//  Copyright © 2021 Sooi De Pauw. All rights reserved.
//

import Foundation
import RealmSwift

class AnimalPersistence: AnimalDelegate {
    
    let realm = try! Realm()
    
    func saveAnimal(_ animal: Animal) {
        try! realm.write {
            realm.add(animal)
        }
    }
}
