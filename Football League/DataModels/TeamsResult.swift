//
//  TeamsResult.swift
//  Football League
//
//  Created by Other user on 11/20/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import  RealmSwift

class TeamsResult : Object, Decodable {
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
