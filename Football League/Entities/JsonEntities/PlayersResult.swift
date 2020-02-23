//
//  TeamInfoResult.swift
//  Football League
//
//  Created by Other user on 11/20/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

class PlayersResult : Object, Decodable {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    var players = List<Player>()
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case players = "squad"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String?.self, forKey: .name)
        let squad = try container.decodeIfPresent([Player].self, forKey: .players) ?? [Player()]
        self.players.append(objectsIn: squad)
    }
}
