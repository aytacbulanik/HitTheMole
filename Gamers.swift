//
//  Gamers.swift
//  HitTheMole
//
//  Created by AYTAÇ BULANIK on 8.10.2022.
//

import Foundation
import UIKit
import RealmSwift

class Gamers : Object , Codable {
    @Persisted var userName : String = ""
    @Persisted var createDate : Date = Date.now
    
    convenience init(userName : String , createDate : Date) {
        self.init()
        self.userName = userName
        self.createDate = createDate
    }
    func jsonToArray(gamers : Data) {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
                do {
        let decodedData = try decoder.decode(GamersArray.self, from: gamers)
                    print(decodedData) //gelen çözümlenen veriyi yazdırıyoruz.
                }catch {
                    print(error)
                }
    }
}

struct GamersArray : Codable {
    var isim : String
    var date : Date
}
