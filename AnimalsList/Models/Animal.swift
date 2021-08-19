//
//  Animal.swift
//  AnimalsList
//
//  Created by Volodymyr Pysarenko on 11.08.2021.
//

import Foundation
import Firebase


struct Animal {
    let name: String
    let type: String
//
//    init(name: String, type: String) {
//        self.name = name
//        self.type = type
//    }
//
    init(snapshot: DataSnapshot) {
        let snapshotValue =  snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        type = snapshotValue["type"] as! String
//        ref = snapshot.ref
    }
//    static let animalsList = [String]()
//
//    static func getAnimals() -> [Animal] {
//
//        var animals = [Animal]()
//
//        for _ in animalsList {
//            animals.append(Animal(name: "Сэм", type: "Собака"))
//        }
//        return animals
//    }
//    func convertToDictionary() -> Any {
//        return ["name": name, "type": type]
//    }
}

