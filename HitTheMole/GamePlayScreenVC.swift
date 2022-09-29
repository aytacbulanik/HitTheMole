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
    var time = 10
    var sayac = Timer()
    
    var name : String? {
        didSet {
           title = name!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        time = 10
        sayac = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sayacSay), userInfo: nil, repeats: true)
    }
    
    @objc func sayacSay() {
        time -= 1
        timeLabel.text = "\(time)"
        if time == 0 {
            sayac.invalidate()
        }
    }

}
