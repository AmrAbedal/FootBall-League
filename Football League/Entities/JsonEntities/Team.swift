//
//  Team.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import  RealmSwift

class Team : Object, Decodable {
    @objc dynamic var leagueId : Int = 0
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    @objc dynamic var shortName : String?
    @objc dynamic var crestUrl : String?
   
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName
        case crestUrl
    }
}
