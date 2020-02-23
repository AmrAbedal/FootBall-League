//
//  RealmTeamsDataSource.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/23/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

class RealmTeamsDataSource: TeamsDataSource {
    func getLeagues() -> Single<TeamsResult> {
        let leagues = DataBaseManager.shared.getObjects(ofType: Team.self)
        let leaguesRersult = TeamsResult()
        leaguesRersult.teams = leagues
        return Single.just(leaguesRersult)
    }
}
