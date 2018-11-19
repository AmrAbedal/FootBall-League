//
//  Leugue.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//
import Foundation
import RealmSwift

class Leagues : Object, Decodable {
    @objc dynamic var count : Int = 0
    var competitions = List<League>()
    private enum CodingKeys: String, CodingKey {
        case id
        case count
        case competitions = "competitions"
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.count = try container.decode(Int.self, forKey: .count)
        let competitions = try container.decodeIfPresent([League].self, forKey: .competitions) ?? [League()]
        self.competitions.append(objectsIn: competitions)
        
    }
    
}


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

//extension League {
//    func updateTeams(teams: [Team]) {
//        safeWrite {
//            teams.removeAll()
//            teams.append(objectsIn:)
//        }
//    }
//}



//{
//    "count": 147,
//    "filters": {},
//    "competitions": [
//    {
//    "id": 2006,
//    "area": {
//    "id": 2001,
//    "name": "Africa"
//    },
//    "name": "WC Qualification",
//    "code": null,
//    "emblemUrl": null,
//    "plan": "TIER_FOUR",
//    "currentSeason": {
//    "id": 7,
//    "startDate": "2015-10-07",
//    "endDate": "2017-11-14",
//    "currentMatchday": 6,
//    "winner": null
//    },
//    "numberOfAvailableSeasons": 1,
//    "lastUpdated": "2018-06-04T23:54:04Z"
//    },

