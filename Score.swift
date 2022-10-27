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
    @Persisted var level : Double = 0.0
    
    convenience init(gamerName : String , scorePuan : Int, scoreDate : Date, level : Double) {
        self.init()
        self.scorePuan = scorePuan
        self.scoreDate = scoreDate
        self.gamerName = gamerName
        self.level = level
    }
}

struct ScoresArray {
    var isim : String
    var score : Int
    var date : Date
    var level : Double
}

