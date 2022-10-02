//
//  Score.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 1.10.2022.
//

import Foundation
import RealmSwift

class Score : Object {
    @Persisted var scorePuan: Int = 0
    @Persisted var scoreDate: Date = Date.now
    
    convenience init(scorePuan : Int, scoreDate : Date) {
        self.init()
        self.scorePuan = scorePuan
        self.scoreDate = scoreDate
    }
}
