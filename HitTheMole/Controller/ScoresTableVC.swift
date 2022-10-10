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
    var bolumler : [Results<Score>?] = []
    var gamers : Results<Gamers>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return gamers?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return gamers?[section].userName ?? "deneme"
    }
    override func viewWillAppear(_ animated: Bool) {
         scores = realm.objects(Score.self)
         gamers = realm.objects(Gamers.self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        if let score = scores?[indexPath.row] {
            cell.textLabel?.text = "Oyuncu : \(score.gamerName) -- Score : \(score.scorePuan)"
            cell.detailTextLabel?.text = dateDesign(date: score.scoreDate)
        }
        
        return cell
    }
    
    func dateDesign(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy' 'HH:mm"
        return formatter.string(from: date)
    }
   
}
