//
//  Leugue.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

class League : Object, Decodable {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    var teams = List<Team>()
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
