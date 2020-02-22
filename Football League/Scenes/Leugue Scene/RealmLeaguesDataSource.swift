//
//  RealmLeaguesDataSource.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

class RealmLeaguesDataSource: LeaguesDataSource {
    func getLeagues() -> Single<LeaguesResult> {
        let leagues = DataBaseManager.shared.getObjects(ofType: League.self)
        let leaguesRersult = LeaguesResult()
        leaguesRersult.leagues = leagues
        return Single.just(leaguesRersult)
    }
}
