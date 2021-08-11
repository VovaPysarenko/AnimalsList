//
//  ViewController.swift
//  AnimalsList
//
//  Created by Volodymyr Pysarenko on 11.08.2021.
//

import UIKit

class AddAnimalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension AddAnimalViewController: UITextFieldDelegate {
    //Скрыввем клаву по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

