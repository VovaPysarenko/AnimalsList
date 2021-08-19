//
//  AnimalListTableViewController.swift
//  AnimalsList
//
//  Created by Volodymyr Pysarenko on 13.08.2021.
//

import UIKit
import Firebase

class AnimalsListTableViewController: UITableViewController {
    
    var ref: DatabaseReference?
//    var databaseHendle: DatabaseHandle?
    private let refDatabase = Database.database().reference().child("Animals")
    var animals = [Animal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAnimals()

//        self.refDatabase.observeSingleEvent(of: .value) { [weak self] snapshot in
//            guard let value = snapshot.value as? [String: Any] else  {
//                return
//            }
//            print("Value: \(value)")
//            var _animals = [Animal]()
//            for item in snapshot.children {
//                let animal = Animal(snapshot: item as! DataSnapshot)
//                _animals.append(animal)
//            }
//            self?.animals = _animals
//            self?.tableView.reloadData()
//            print("Animal: \(self?.animals)")
            
    }
        func getAnimals() {
            self.refDatabase.observeSingleEvent(of: .value) { [weak self] snapshot in
                guard let value = snapshot.value as? [String: Any] else  {
                    return
                }
                print("Value: \(value)")
                var _animals = [Animal]()
                for item in snapshot.children {
                    let animal = Animal(snapshot: item as! DataSnapshot)
                    _animals.append(animal)
                }
                self?.animals = _animals
                self?.tableView.reloadData()
        }
}

        
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animals.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let animal = animals[indexPath.row]
        let nameTitle = animal.name
        let typeTitle = animal.type
        cell.nameTextField.text = nameTitle
        cell.typeTextField.text = typeTitle

        return cell
    }



}
