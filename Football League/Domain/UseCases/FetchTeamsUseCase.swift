//
//  FetchTeamsUseCase.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/23/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//


import Foundation
import RxSwift
import RealmSwift

func fetchTeams(dataSource: TeamsDataSource, localDataSource: TeamsDataSource) -> Single<TeamsScreenData> {
    func addObjectsToRealm(objects: List<Team>) {
        for object in objects {
            DataBaseManager.shared.addOrUpdateObject(object: object)
        }
    }
    
    return dataSource.getLeagues()
        .map({
            addObjectsToRealm(objects: $0.teams)
            return $0.screenData
        })
        .catchError({ _ in
            localDataSource.getLeagues()
                .map({
                    if !$0.teams.isEmpty {
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
