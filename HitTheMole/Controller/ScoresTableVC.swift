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
    var scoreArray : [ScoresArray] = []
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreArray.count
    }
   
    override func viewWillAppear(_ animated: Bool) {
       
        scores = realm.objects(Score.self)
        guard let scores else {return}
        scoreArray.removeAll(keepingCapacity: true)
        
        for score in scores {
            let isim = score.gamerName
            let gamescore = score.scorePuan
            let date = score.scoreDate
            let newScore : ScoresArray = ScoresArray(isim: isim, score: gamescore, date: date)
            scoreArray.append(newScore)
        }
       
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        let scores = scoreArray[indexPath.row]
        cell.textLabel?.text = "\(scores.isim) : \(scores.score)"
        cell.detailTextLabel?.text = "\(dateDesign(date: scores.date))"
        return cell
    }
    
    func dateDesign(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy' 'HH:mm"
        return formatter.string(from: date)
    }
   
}
