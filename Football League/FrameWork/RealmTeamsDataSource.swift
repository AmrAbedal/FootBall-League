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
    func getTeamsWith(leagueID: Int) -> Single<TeamsResult> {
        let teams = DataBaseManager.shared.getObjects(ofType: Team.self).filter("leagueId == \(leagueID)")
        let teamsResult = TeamsResult()
        teamsResult.teams = teams.resultList
        return Single.just(teamsResult)
    }
}
