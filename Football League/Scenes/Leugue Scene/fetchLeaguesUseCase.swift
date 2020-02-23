//
//  fetchLeaguesUseCase.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

func fetchLeagues(dataSource: LeaguesDataSource, localDataSource: LeaguesDataSource) -> Single<LeaguesScreenData> {
    func addObjectsToRealm(objects: List<League>) {
        for object in objects {
            DataBaseManager.shared.addOrUpdateObject(object: object)
        }
    }
    
    return dataSource.getLeagues()
        .map({
            addObjectsToRealm(objects: $0.leagues)
            return $0.screenData
        })
        .catchError({ _ in
            localDataSource.getLeagues()
                .map({
                    if !$0.leagues.isEmpty {
                        return $0.screenData
                    } else {
                        return .failure(error: "No Iternet OR Cached Data")
                    }
                })
                .catchError({ _ in
                    return .just(.failure(error: "No Iternet OR Cached Data"))
                })
            }
    )
}
