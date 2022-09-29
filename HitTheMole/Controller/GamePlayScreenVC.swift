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
    
    @IBOutlet var scoreBarButton : UIBarButtonItem!
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
        scoreBarButton.isEnabled = false
        time = 10
        sayac = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sayacSay), userInfo: nil, repeats: true)
    }
    
    @objc func sayacSay() {
        time -= 1
        timeLabel.text = "\(time)"
        if time == 0 {
            sayac.invalidate()
            time = 10
            timeLabel.text = "10"
            showAlert(name: "Game Over", description: "Do want to play again")
        }
    }
    
    func showAlert(name : String , description : String) {
        let alert = UIAlertController(title: name, message: description, preferredStyle: .alert)
        let replayButton = UIAlertAction(title: "REPLAY", style: .default) { _ in
            self.sayac = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.sayacSay), userInfo: nil, repeats: true)
        }
        let okButton = UIAlertAction(title: "OK", style: .cancel) {
            _ in
            self.scoreBarButton.isEnabled = true
        }
        alert.addAction(okButton)
        alert.addAction(replayButton)
        present(alert, animated: true)
    }

}
