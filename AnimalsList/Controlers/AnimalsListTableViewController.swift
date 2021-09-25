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
        getAnimals() { animals in
            self.animals = animals
            self.tableView.reloadData()
            print("animals: \(animals) ")
        }
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let animal = animals[indexPath.row]
            print("2- \(animal)")
            deleteAnimal(idKey: animal.id)
            animals.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAnimal" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let animal = animals[indexPath.row]
            let newPlaceVC = segue.destination as! AddAnimalViewController
            newPlaceVC.currentAnimal = animal
        }
    }


    private func getAnimals(completion: @escaping (([Animal]) -> Void)) {
        self.ref?.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
            guard let data = try? JSONSerialization
                    .data(withJSONObject: snapshot.value as Any, options: []),
                  let animal = try? JSONDecoder().decode([String: Animal].self, from: data) else {
                completion([])
                return
            }
                print("data\(data)")
                print("animal\(animal)")

                let list = animal.map { $0.value }
            completion(list)
                print("list  ----  \(list)")
            } else {
                completion([])
            }
            
            
            
//            var _animals = [Animal]()
//            for item in snapshot.children {
//                let animal = Animal(snapshot: item as! DataSnapshot)
//                _animals.append(animal)
//            }
//            if !_animals.isEmpty {
//                completion(_animals)
//            }
        })
    }
    func deleteAnimal(idKey: String?) {
        guard let idKey = idKey else {return}
        ref?.child(idKey).removeValue()
        print("1- \(idKey)")
    }
    
}

