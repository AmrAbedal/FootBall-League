//
//  MoayTeamsDataSource.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/23/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class MoyaTeamsDataSource: TeamsDataSource {
    let moyaProvider = MoyaProvider<LeaguesApi>()
    func getLeagues() -> Single<TeamsResult> {
        return moyaProvider.rx.request(.leagues)
            .map {
                try JSONDecoder().decode(TeamsResult.self, from: $0.data)
        }
    }
}
