//
//  ViewController.swift
//  AnimalsList
//
//  Created by Volodymyr Pysarenko on 11.08.2021.
//

import UIKit
import Firebase
//import FirebaseDatabase

class AddAnimalViewController: UIViewController {
    
    var ref: DatabaseReference!
    private let refDatabase = Database.database().reference().child("Animals")

    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var addAnimalButton: UIButton!
    
    
    func saveAnimal() {
        let animal: [String: Any] = [
            "name": nameText.text!,
            "type": typeText.text!
        ]
        refDatabase.childByAutoId().setValue(animal)
    }
    
    func clearField() {
        nameText.text = ""
        typeText.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
//        self.refDatabase.observeSingleEvent(of: .value) { snapshot in
//            guard let value = snapshot.value as? [String: Any] else  {
//                return
//            }
//            print("Value: \(value)")
//        }
        nameText.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        typeText.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addAnimalButton.isEnabled = false

    }
    
    @IBAction func addAnimalPressed(_ sender: UIButton) {
        saveAnimal()
        clearField()
    }
}

extension AddAnimalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if nameText.text?.isEmpty == false && typeText.text?.isEmpty == false {
            addAnimalButton.isEnabled = true
        } else {
            addAnimalButton.isEnabled = false

        }
    }
    
}






