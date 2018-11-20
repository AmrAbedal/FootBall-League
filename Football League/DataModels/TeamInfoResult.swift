//
//  TeamInfoResult.swift
//  Football League
//
//  Created by Other user on 11/20/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

class TeamInfoResult : Object, Decodable {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String?
    @objc dynamic var shortName : String?
    @objc dynamic var crestUrl : String?
    @objc dynamic var founded : Int = 0
    var squad = List<Player>()
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName
        case crestUrl
        case founded
        case squad = "squad"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String?.self, forKey: .name)
        self.shortName = try container.decode(String?.self, forKey: .shortName)
        self.crestUrl = try container.decode(String?.self, forKey: .crestUrl)
        self.founded = try container.decode(Int.self, forKey: .founded)
        let squad = try container.decodeIfPresent([Player].self, forKey: .squad) ?? [Player()]
        self.squad.append(objectsIn: squad)
        
    }
    
}
