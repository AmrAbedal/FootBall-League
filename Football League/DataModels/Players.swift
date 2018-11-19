//
//  Players.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift


class TeamInfo : Object, Decodable {
    @objc dynamic var id : Int = 0
    var squad = List<Player>()
    private enum CodingKeys: String, CodingKey {
        case id
        case squad = "squad"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        
        let squad = try container.decodeIfPresent([Player].self, forKey: .squad) ?? [Player()]
        self.squad.append(objectsIn: squad)
        
    }
    
}


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



//{
//    "id": 758,
//    "area": {
//        "id": 2257,
//        "name": "Uruguay"
//    },
//    "activeCompetitions": [],
//    "name": "Uruguay",
//    "shortName": "Uruguay",
//    "tla": "URU",
//    "crestUrl": null,
//    "address": "Guayaybo 1531 Montevideo 11200",
//    "phone": "+59 (82) 4004814",
//    "website": "http://www.auf.org.uy",
//    "email": "auf@auf.org.uy",
//    "founded": 1900,
//    "clubColors": "Sky Blue / White / Black",
//    "venue": "Olimpiyskiy Stadion Fisht",
//    "squad": [
//    {
//    "id": 96,
//    "name": "Federico Valverde",
//    "position": "Midfielder",
//    "dateOfBirth": "1998-07-22T00:00:00Z",
//    "countryOfBirth": "Uruguay",
//    "nationality": "Uruguay",
//    "shirtNumber": null,
//    "role": "PLAYER"
//    },

