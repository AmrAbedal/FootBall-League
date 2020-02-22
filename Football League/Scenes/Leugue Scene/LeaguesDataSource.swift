//
//  LeaguesDataSource.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol LeaguesDataSource {
    func getLeagues() -> Single<LeaguesResult>
    
}

class MoyaLeagesDataSource: LeaguesDataSource {
    let moyaProvider = MoyaProvider<LeaguesApi>()
    func getLeagues() -> Single<LeaguesResult> {
        return moyaProvider.rx.request(.leagues)
            .map {
                try JSONDecoder().decode(LeaguesResult.self, from: $0.data)
        }
    }
}
