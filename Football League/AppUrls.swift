//
//  AppUrls.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation

struct AppUrls {
    private static let versionNumber = 2
    static let baseUrl = "http://api.football-data.org"
    static let competitions = "/competitions"
     static let teams = "/teams"
    static var version: String {
        return "/v\(versionNumber)"
    }
    static var leagues = baseUrl + version + competitions
    //    static let leagues = "http://api.football-data.org/v2/competitions"
    
    static func teamUrlOfLeageId(leagueid: Int) -> String {
        return baseUrl + version + competitions + "/\(leagueid)" + teams
        //        return "http://api.football-data.org/v2/competitions/\(leagueid)/teams"
    }
    static func teamInfoUrl(ofTeamId teamId: Int) -> String {
        return baseUrl + version + teams + "/\(teamId)"
        //        return "http://api.football-data.org/v2/teams/\(teamId)"
    }
}
