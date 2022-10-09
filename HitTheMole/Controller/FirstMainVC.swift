//
//  FirstMainVC.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 28.09.2022.
//

import UIKit
import RealmSwift

class FirstMainVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField : UITextField!
    var username : String = ""
    var realm = try! Realm()
    var gamers : Results<Gamers>?
    var level = 0.0
    var picker = UIPickerView()
    var toolbar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .darkGray
        nameTextField.inputView = picker
        configToolbar()
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
    
    @IBAction func newUserButtonPressed(_ sender : UIBarButtonItem) {
           addUser()
        
    }
    
    @IBAction func playButtonPressed(_ sender : UIButton) {
        if let name = nameTextField.text {
            if !name.isEmpty {
                username = name
                levelConfig()
            }
        }
    }
    
    func configToolbar() {
        toolbar.sizeToFit()
        let okButton = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: #selector(closePicker))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flexButton,okButton]
        nameTextField.inputAccessoryView = toolbar
    }
    @objc func closePicker() {
        view.endEditing(true)
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
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(easyButton)
        alert.addAction(mediumButton)
        alert.addAction(hardButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    func addUser() {
        let alert = UIAlertController(title: "New User !!!", message: "Please, write a new user", preferredStyle: .alert)
        var textField = UITextField()
        alert.addTextField() {
            txtField in
            txtField.placeholder = "Write a name"
            textField = txtField
        }
        let saveButton = UIAlertAction(title: "SAVE", style: .default) {
            action in
            guard let name = textField.text else {return}
            let user = Gamers(userName: name.uppercased(), createDate: Date.now)
            do {
                try self.realm.write({
                    self.realm.add(user)
                })
            }catch {
                print(error.localizedDescription)
            }
        }
        let cancelButton = UIAlertAction(title: "CANCEL", style: .destructive)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
}

extension FirstMainVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gamers?.count ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        gamers = realm.objects(Gamers.self)
        return gamers?[row].userName ?? "No User"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameTextField.text = gamers?[row].userName ?? "No User"
    }
    
    
    
    
}
