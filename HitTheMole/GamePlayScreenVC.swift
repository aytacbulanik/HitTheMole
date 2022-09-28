//
//  GamePlayScreenVC.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 28.09.2022.
//

import UIKit

class GamePlayScreenVC: UIViewController {
    
    
    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var scoreLabel : UILabel!
    @IBOutlet var highScoreLabel : UILabel!
    
    var name : String? {
        didSet {
            print(name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
