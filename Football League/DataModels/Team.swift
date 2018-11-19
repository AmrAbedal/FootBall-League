//
//  Team.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import  RealmSwift


class Teams : Object, Decodable {
    @objc dynamic var count : Int = 0
    var teams = List<Team>()
    private enum CodingKeys: String, CodingKey {
        case count
        case teams = "teams"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try container.decode(Int.self, forKey: .count)
        
        let teams = try container.decodeIfPresent([Team].self, forKey: .teams) ?? [Team()]
        self.teams.append(objectsIn: teams)
        
    }
    
}


class Team : Object, Decodable {
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




//{
//    "count": 24,
//    "filters": {},
//    "teams": [
//    {
//    "id": 58,
//    "area": {
//    "id": 2072,
//    "name": "England"
//    },
//    "name": "Aston Villa FC",
//    "shortName": "Aston Villa",
//    "tla": "AST",
//    "crestUrl": "http://upload.wikimedia.org/wikipedia/de/9/9f/Aston_Villa_logo.svg",
//    "address": "Villa Park Birmingham B6 6HE",
//    "phone": "+44 (0121) 3272299",
//    "website": "http://www.avfc.co.uk",
//    "email": null,
//    "founded": 1872,
//    "clubColors": "Claret / Sky Blue",
//    "venue": "Villa Park",
//    "lastUpdated": "2018-10-15T15:08:15Z"
//}

