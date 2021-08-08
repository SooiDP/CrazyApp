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
        let predicate = NSPredicate(format: "url = %@", animal.url)
        if (realm.objects(Animal.self).filter(predicate).first != nil) {
            return
        }
        try! realm.write {
            realm.add(animal)
        }
    }
    
    func favouriteAnimal(_ animalUrl: String) {
        let predicate = NSPredicate(format: "url = %@", animalUrl)
        let animal = realm.objects(Animal.self).filter(predicate).first
        try! realm.write {
            animal!.favourite = !animal!.favourite
        }
    }
}
