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
    //var bolumler : [Score] = []
    var gamers : Results<Gamers>?
    var gamersObject : Gamers?
    var bolumler = ["Meyve","Sebze","araba"]
    var bolumVerisi = [["Elma","Armut","Çilek"],["Karnıbahar","patates",],["ferrari","Audi","Mercedes","BMW"]]
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return bolumler.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bolumVerisi[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return bolumler[section]
    }
    override func viewWillAppear(_ animated: Bool) {
         scores = realm.objects(Score.self)
         gamers = realm.objects(Gamers.self)
        gamersObject?.jsonToArray(gamers: gamers)
        guard let scores else {return}
        for score in scores {
            print(gamers)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = bolumVerisi[indexPath.section][indexPath.row]
        return cell
    }
    
    func dateDesign(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy' 'HH:mm"
        return formatter.string(from: date)
    }
   
}
