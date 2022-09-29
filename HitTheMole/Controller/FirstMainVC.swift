//
//  FirstMainVC.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 28.09.2022.
//

import UIKit

class FirstMainVC: UIViewController {
    
    @IBOutlet var nameTextField : UITextField!
    var username : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPlaySegue" {
            let baglanti = segue.destination as! GamePlayScreenVC
            baglanti.name = username
        }
    }
    

    @IBAction func playButtonPressed(_ sender : UIButton) {
        if let name = nameTextField.text {
            if !name.isEmpty {
                username = name
                performSegue(withIdentifier: "goPlaySegue", sender: nil)
            }
        }
    }

}