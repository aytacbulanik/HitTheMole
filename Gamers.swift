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
    class func getSomeObject() -> [GamersArray]? {
        let objects = try? Realm().objects(Gamers.self).toArray(ofType: GamersArray.self) as [GamersArray]
        
        return objects?.count ?? 0 > 0 ? objects : nil
    }
}
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
   
}
struct GamersArray {
    var isim : String
    var date : Date
}
