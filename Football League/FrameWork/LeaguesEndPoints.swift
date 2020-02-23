//
//  LeaguesEndPoints.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/23/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//


import Foundation
import RxSwift
import Moya
import Alamofire


extension LeaguesApi : TargetType {
    var baseURL: URL {
        switch self {
        case .leagues , .teams:
            return URL.init(string: AppUrls.baseUrl + AppUrls.version)!
        }
    }
    
    var path: String  {
           switch self {
           case .leagues :
            return AppUrls.competitions
           case .teams(leagueID: let leagueID):  return AppUrls.competitions  + "/\(leagueID)" + AppUrls.teams
           }
       }
    
    var method: HTTPMethod  {
           switch self {
           case .leagues ,.teams:
            return .get
           }
       }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return [FootBallAppConstants.tokenName: FootBallAppConstants.token]
    }
}
