//
//  AnimalListTableViewController.swift
//  AnimalsList
//
//  Created by Volodymyr Pysarenko on 13.08.2021.
//

import UIKit
import Firebase

class AnimalsListTableViewController: UITableViewController {
    
    private var ref: DatabaseReference?
    private var animals = [Animal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("Animals")

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
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let animal = animals[indexPath.row]
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
//            animal.ref?.removeValue()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//            return configuration
//    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let animal = animals[indexPath.row]
            animal.ref?.removeValue()
//            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
    }
    
    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return.delete
//    }
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            tableView.beginUpdates()
//            animals.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .left)
//            animal.ref?.removeValue()
//            tableView.endUpdates()
//        }
//    }

    private func getAnimals() {
        self.ref?.observeSingleEvent(of: .value, with: { [weak self] snapshot in

            var _animals = [Animal]()
            for item in snapshot.children {
                let animal = Animal(snapshot: item as! DataSnapshot)
                _animals.append(animal)
            }
            self?.animals = _animals
            self?.tableView.reloadData()
        })
    }
    
}
