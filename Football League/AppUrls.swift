//
//  AppUrls.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation


struct AppUrls {
    static let leagues = "http://api.football-data.org/v2/competitions"
    
    static func teamUrlOfLeageId(leagueid: Int) -> String {
        return "http://api.football-data.org/v2/competitions/\(leagueid)/teams"
    }
    static func teamInfoUrl(ofTeamId teamId: Int) -> String {
        return "http://api.football-data.org/v2/teams/\(teamId)"
    }
}
