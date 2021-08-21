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
    @IBOutlet weak var addAnimalButton: UIButton!
    
    private var ref: DatabaseReference!
    private let refDatabase = Database.database().reference().child("Animals")
    private var animals = [Animal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        refDatabase.childByAutoId().setValue(animal)
        
    }
    
    private func clearField() {
        nameText.text = ""
        typeText.text = ""
    }
}







