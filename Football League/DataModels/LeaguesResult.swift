//
//  LeaguesResult.swift
//  Football League
//
//  Created by Other user on 11/20/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

class LeaguesResult : Object, Decodable {
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
