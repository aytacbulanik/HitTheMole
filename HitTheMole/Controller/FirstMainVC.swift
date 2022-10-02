//
//  FirstMainVC.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 28.09.2022.
//

import UIKit

class FirstMainVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField : UITextField!
    var username : String = ""
    var level = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPlaySegue" {
            let baglanti = segue.destination as! GamePlayScreenVC
            baglanti.name = username
            baglanti.comeLevel = level
        }
    }
    

    @IBAction func playButtonPressed(_ sender : UIButton) {
        if let name = nameTextField.text {
            if !name.isEmpty {
                username = name
                levelConfig()
            }
        }
    }
    
    func levelConfig() {
        let alert = UIAlertController(title: "Level", message: "Hangi seviyede oynamak istiyorsunuz", preferredStyle: .actionSheet)
        let easyButton = UIAlertAction(title: "Easy", style: .default) {
            action in
            self.level = 0.5
            self.performSegue(withIdentifier: "goPlaySegue", sender: nil)
        }
        let mediumButton = UIAlertAction(title: "Medium", style: .default) {
            action in
            self.level = 0.35
            self.performSegue(withIdentifier: "goPlaySegue", sender: nil)
        }
        let hardButton = UIAlertAction(title: "Hard", style: .default) {
            action in
            self.level = 0.2
            self.performSegue(withIdentifier: "goPlaySegue", sender: nil)
        }
        alert.addAction(easyButton)
        alert.addAction(mediumButton)
        alert.addAction(hardButton)
        present(alert, animated: true)
    }

}
