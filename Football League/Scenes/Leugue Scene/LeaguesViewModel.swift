//
//  LeaguesViewModel.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift

enum LeaguesScreenData {
    case success([LeagueScreenData])
    case loading
    case failure(error:String)
}
struct LeagueScreenData {
    let name: String
    let hasMoreInfo: Bool
}

class LeaguesViewModel {
    private var disposeBage = DisposeBag()
    private var dataSource: LeaguesDataSource
    typealias loadLeagesUseCaseType = (LeaguesDataSource)->(Single<LeaguesScreenData>)
    private var loadLeaguesUseCase: loadLeagesUseCaseType
    var leaguesSubject = BehaviorSubject<LeaguesScreenData>(value: .loading)
    init(dataSource: LeaguesDataSource = MoyaLeagesDataSource(),
         loadLeaguesUseCase: @escaping loadLeagesUseCaseType = fetchLeagues) {
        self.dataSource = dataSource
        self.loadLeaguesUseCase = loadLeaguesUseCase
        loadData()
    }
    private func loadData() {
        loadLeaguesUseCase(dataSource).subscribe(onSuccess: {[weak self] leagueScreenData in
            self?.leaguesSubject.onNext(leagueScreenData)
        }, onError: { [weak self] error in
            self?.leaguesSubject.onNext(.failure(error: "Server Error"))
            }).disposed(by: disposeBage)
    }
    func didSelectRowAt(index: Int ) {
        
    }
}

