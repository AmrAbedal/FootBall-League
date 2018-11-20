//
//  Players.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

class Player : Object, Decodable {
    @objc dynamic var teamID : Int = 0
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    @objc dynamic var position : String?
    @objc dynamic var nationality : String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case position
        case nationality
    }
}
