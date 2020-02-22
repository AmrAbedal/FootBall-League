//
//  LeaguesApi.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire


enum LeaguesApi : TargetType {
    case leagues
    var baseURL: URL {
        switch self {
        case .leagues:
            return URL.init(string: AppUrls.baseUrl + AppUrls.version)!
        }
    }
    
    var path: String  {
           switch self {
           case .leagues:
            return AppUrls.competitions
           }
       }
    
    var method: HTTPMethod  {
           switch self {
           case .leagues:
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
