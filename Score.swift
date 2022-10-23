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
}

