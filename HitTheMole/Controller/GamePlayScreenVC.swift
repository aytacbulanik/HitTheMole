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
    
    @IBOutlet var holeImage1 : UIImageView!
    @IBOutlet var holeImage2 : UIImageView!
    @IBOutlet var holeImage3 : UIImageView!
    @IBOutlet var holeImage4 : UIImageView!
    @IBOutlet var holeImage5 : UIImageView!
    @IBOutlet var holeImage6 : UIImageView!
    @IBOutlet var holeImage7 : UIImageView!
    @IBOutlet var holeImage8 : UIImageView!
    @IBOutlet var holeImage9 : UIImageView!
    
    var time = 10
    var score = 0
    var sayac = Timer()
    
    var name : String? {
        didSet {
           title = name!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
       
        gestureManage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scoreBarButton.isEnabled = false
        time = 10
        score = 0
        sayac = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sayacSay), userInfo: nil, repeats: true)
    }
    
    @objc func sayacSay() {
        time -= 1
        timeLabel.text = "\(time)"
        if time == 0 {
            sayac.invalidate()
            time = 10
            scoreLabel.text = "Score : \(score)"
            timeLabel.text = "10"
            showAlert(name: "Game Over", description: "Score : \(score) ---- Do want to play again")
        }
    }
    @objc func upScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    func gestureManage() {
        holeImage1.isUserInteractionEnabled = true
        holeImage2.isUserInteractionEnabled = true
        holeImage3.isUserInteractionEnabled = true
        holeImage4.isUserInteractionEnabled = true
        holeImage5.isUserInteractionEnabled = true
        holeImage6.isUserInteractionEnabled = true
        holeImage7.isUserInteractionEnabled = true
        holeImage8.isUserInteractionEnabled = true
        holeImage9.isUserInteractionEnabled = true
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage1.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage2.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage3.addGestureRecognizer(gesture3)
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage4.addGestureRecognizer(gesture4)
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage5.addGestureRecognizer(gesture5)
        let gesture6 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage6.addGestureRecognizer(gesture6)
        let gesture7 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage7.addGestureRecognizer(gesture7)
        let gesture8 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage8.addGestureRecognizer(gesture8)
        let gesture9 = UITapGestureRecognizer(target: self, action: #selector(upScore))
        holeImage9.addGestureRecognizer(gesture9)
    }
    
    func showAlert(name : String , description : String) {
        let alert = UIAlertController(title: name, message: description, preferredStyle: .alert)
        let replayButton = UIAlertAction(title: "REPLAY", style: .default) { _ in
            self.score = 0
            self.scoreLabel.text = "Score : \(self.score)"
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
