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

            
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAnimals()
    }
    

        
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    
    // MARK: - Delete row
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let animal = animals[indexPath.row].self

            tableView.beginUpdates()
            
            deleteAnimal()
            
            animals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }

    func getAnimals() {
        self.refDatabase.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            //                guard let value = snapshot.value as? [String: Any] else  {
            //                    return
            //                }
            //                print("Value: \(value)")
            var _animals = [Animal]()
            for item in snapshot.children {
                let animal = Animal(snapshot: item as! DataSnapshot)
                _animals.append(animal)
            }
            self?.animals = _animals
            self?.tableView.reloadData()
        })
    }
    
    func deleteAnimal() {

    }
  
}
