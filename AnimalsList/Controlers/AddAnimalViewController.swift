//
//  ViewController.swift
//  AnimalsList
//
//  Created by Volodymyr Pysarenko on 11.08.2021.
//

import UIKit
import Firebase

class AddAnimalViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var saveAnimalButton: UIButton!
    
    private var ref: DatabaseReference!
//    private let refDatabase = Database.database().reference().child("Animals")
    private var animals = [Animal]()
    var currentAnimal: Animal?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("Animals")
        setupEditScreen()
        
    }
    
    @IBAction func addAnimalPressed(_ sender: UIButton) {
        saveAnimal()
        clearField()
    }
    
    private func saveAnimal() {
        guard let nameText = nameText.text, self.nameText.text != "" else {return}
        guard let typeText = typeText.text, self.typeText.text != "" else {return}
                
        let animal: [String: Any] = [
            "name": nameText,
            "type": typeText
        ]
        
        if currentAnimal != nil {
            
            self.ref?.getData { [weak self] (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    let current = self?.currentAnimal
                    current?.ref?.setValue(animal)
                    self?.dismiss(animated: true, completion: nil)
                    print("Got data \(snapshot.value!)")
                }
                else {
                    print("No data available")
                }
            }
    } else {
            ref.childByAutoId().setValue(animal)
        }
    }
    
    private func clearField() {
        nameText.text = ""
        typeText.text = ""
    }
    
    private func setupEditScreen() {  // экран редактирования
        if currentAnimal != nil {
            nameText.text = currentAnimal?.name
            typeText.text = currentAnimal?.type
        }
    }
}

extension AddAnimalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}






