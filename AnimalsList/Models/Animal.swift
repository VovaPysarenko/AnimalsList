//
//  Animal.swift
//  AnimalsList
//
//  Created by Volodymyr Pysarenko on 11.08.2021.
//

import Foundation
import Firebase
import CodableFirebase

struct Animal: Codable {
    let id: String?
    let name: String
    let type: String
//    let ref: DatabaseReference?
//
    init(id: String, name: String, type: String) {
        self.id = id
        self.name = name
        self.type = type
//        self.ref = nil
    }
//
//    init(snapshot: DataSnapshot) {
//        let snapshotValue =  snapshot.value as! [String: AnyObject]
//        name = snapshotValue["name"] as! String
//        type = snapshotValue["type"] as! String
//        ref = snapshot.ref
//    }
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

