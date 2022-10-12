//
//  ScoresTableVC.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 29.09.2022.
//

import UIKit
import RealmSwift

class ScoresTableVC: UITableViewController {
    
    var scores : Results<Score>?
    var gamers : Results<Gamers>?
    var gameArray : [GamersArray] = []
    var scoreArray : [ScoreArray] = []
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return gameArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameArray.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return gameArray[section].isim
    }
    override func viewWillAppear(_ animated: Bool) {
       
        scores = realm.objects(Score.self)
        gamers = realm.objects(Gamers.self)
        
        guard let gamers else {return}
        guard let scores else {return}
        gameArray.removeAll(keepingCapacity: true)
        scoreArray.removeAll(keepingCapacity: true)
        
        for score in scores {
            print(score)
        }
        
        for game in gamers {
            let name = game.userName
            let date = game.createDate
            let gameArrayObject : GamersArray = GamersArray(isim: name, date: date)
            gameArray.append(gameArrayObject)
        }
        
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = "Deneme"
        return cell
    }
    
    func dateDesign(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy' 'HH:mm"
        return formatter.string(from: date)
    }
   
}
