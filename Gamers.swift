//
//  Gamers.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 8.10.2022.
//

import Foundation
import RealmSwift

class Gamers : Object {
    @Persisted var userName : String = ""
    @Persisted var createDate : Date = Date.now
    
    convenience init(userName : String , createDate : Date) {
        self.init()
        self.userName = userName
        self.createDate = createDate
    }
    
}

