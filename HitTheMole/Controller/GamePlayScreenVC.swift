//
//  GamePlayScreenVC.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 28.09.2022.
//

import UIKit
import RealmSwift

class GamePlayScreenVC: UIViewController {

    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var scoreLabel : UILabel!
    @IBOutlet var highScoreLabel : UILabel!
    
    @IBOutlet var scoreBarButton : UIBarButtonItem!
    @IBOutlet var newGameButton : UIBarButtonItem!
    
    @IBOutlet var holeImage1 : UIImageView!
    @IBOutlet var holeImage2 : UIImageView!
    @IBOutlet var holeImage3 : UIImageView!
    @IBOutlet var holeImage4 : UIImageView!
    @IBOutlet var holeImage5 : UIImageView!
    @IBOutlet var holeImage6 : UIImageView!
    @IBOutlet var holeImage7 : UIImageView!
    @IBOutlet var holeImage8 : UIImageView!
    @IBOutlet var holeImage9 : UIImageView!
    var picker = UIPickerView()
    var imageArray = [UIImageView]()
    var time = 10
    var score = 0
    var bestScore = 0
    var sayac = Timer()
    var imageSayac = Timer()
    let realm = try! Realm()
    var name : String? {
        didSet {
            title = name!.uppercased()
        }
    }
    var comeLevel : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        imageArray.append(holeImage1)
        imageArray.append(holeImage2)
        imageArray.append(holeImage3)
        imageArray.append(holeImage4)
        imageArray.append(holeImage5)
        imageArray.append(holeImage6)
        imageArray.append(holeImage7)
        imageArray.append(holeImage8)
        imageArray.append(holeImage9)
        
        for image in imageArray {
            image.isHidden = true
        }
        newGame()
        gestureManage()
        bestScoreClaculate()
        
    }
    
    @IBAction func newGameButtonPressed(_ sender : UIBarButtonItem) {
        askNewGameUser()
        //levelConfig()
    }
    
    func newGame() {
        scoreBarButton.isEnabled = false
        newGameButton.isEnabled = false
        time = 10
        score = 0
        self.scoreLabel.text = "Score : \(self.score)"
        guard let level = comeLevel else {return}
        sayac = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sayacSay), userInfo: nil, repeats: true)
        imageSayac = Timer.scheduledTimer(timeInterval: level, target: self, selector: #selector(imageChange), userInfo: nil, repeats: true)
    }
    
    @objc func sayacSay() {
        time -= 1
        timeLabel.text = "\(time)"
        if time == 0 {
            sayac.invalidate()
            imageSayac.invalidate()
            time = 10
            scoreLabel.text = "Score : \(score)"
            timeLabel.text = "10"
            showAlert(name: "Game Over",
            description: """
            Score : \(score)
            Do want to play again
            """)
            guard let gamerName = title else {return}
            let score = Score(gamerName : gamerName, scorePuan: score, scoreDate: Date.now)
            try! realm.write {
                realm.add(score)
            }
            bestScoreClaculate()
        }
    }
    
    @objc func imageChange() {
        for image in imageArray {
            image.isHidden = true
        }
        imageArray.randomElement()?.isHidden = false
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
            self.newGame()
        }
        let okButton = UIAlertAction(title: "OK", style: .cancel) {
            _ in
            self.scoreBarButton.isEnabled = true
            self.newGameButton.isEnabled = true
            
        }
        alert.addAction(okButton)
        alert.addAction(replayButton)
        present(alert, animated: true)
    }
    func levelConfig() {
        let alert = UIAlertController(title: "Level", message: "Hangi seviyede oynamak istiyorsunuz", preferredStyle: .actionSheet)
        let easyButton = UIAlertAction(title: "Easy", style: .default) {
            action in
            self.comeLevel = 0.5
            self.newGame()
        }
        let mediumButton = UIAlertAction(title: "Medium", style: .default) {
            action in
            self.comeLevel = 0.35
            self.newGame()
        }
        let hardButton = UIAlertAction(title: "Hard", style: .default) {
            action in
            self.comeLevel = 0.2
            self.newGame()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(easyButton)
        alert.addAction(mediumButton)
        alert.addAction(hardButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    func bestScoreClaculate() {
        let scores = realm.objects(Score.self)
        for score in scores {
            if score.scorePuan > bestScore {
                bestScore = score.scorePuan
                highScoreLabel.text = "High Score : \(score.gamerName) -- \(score.scorePuan)"
            }
        }
    }
    func askNewGameUser() {
        let alert = UIAlertController(title: "New Game", message: "Please choose a user", preferredStyle: .alert)
        let playButton = UIAlertAction(title: "Play", style: .default)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        let textField = UITextField()
        textField.inputAccessoryView = picker
        alert.addTextField { txtField in
            txtField.placeholder = "Choose User"
            textField.text = txtField.text
        }
        alert.addAction(playButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: levelConfig)
    }

}
/*
 extension GamePlayScreenVC : UIPickerViewDelegate , UIPickerViewDataSource {
 
 }
 */
