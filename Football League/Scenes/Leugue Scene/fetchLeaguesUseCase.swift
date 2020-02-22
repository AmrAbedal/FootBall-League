//
//  fetchLeaguesUseCase.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift

func fetchLeagues(dataSource: LeaguesDataSource) -> Single<LeaguesScreenData> {
    return dataSource.getLeagues().map({
        return $0.screenData
    })
}
