//
//  Score.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 1.10.2022.
//

import Foundation
import RealmSwift

class Score : Object {
    @Persisted var gamerName: String = ""
    @Persisted var scorePuan: Int = 0
    @Persisted var scoreDate: Date = Date.now
    
    convenience init(gamerName : String , scorePuan : Int, scoreDate : Date) {
        self.init()
        self.scorePuan = scorePuan
        self.scoreDate = scoreDate
        self.gamerName = gamerName
    }
}

struct ScoresArray {
    var isim : String
    var score : Int
    var date : Date
    var isimler : String {
        return isim
    }
    
    }


struct ScoreArrayData {
    static var scores : Results<Score> {
        return try! Realm().objects(Score.self)
    }
    static var uniqueIsimler : [String] {
        let gamers = scores.map { $0.gamerName }
        let uniqueLetters = Set(gamers)
        return Array(uniqueLetters).sorted()
        }
        static var sectinedContacts : [[Score]] {
            return uniqueIsimler.map { firstletter in
                let filteredContacts = scores.filter { $0.gamerName == firstletter }
                return filteredContacts.sorted(by: {$0.gamerName < $1.gamerName})
            }
        }
}
