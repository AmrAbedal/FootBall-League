//
//  TeamsPresenter.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class TeamsViewModel {
    let leagueID: Int
    private var disposeBage = DisposeBag()
    private var dataSource: TeamsDataSource
    private var localDataSource: TeamsDataSource
    typealias loadTeamsUseCaseType = (Int,TeamsDataSource,TeamsDataSource)->(Single<TeamsScreenData>)
    private var loadteamsUseCase: loadTeamsUseCaseType
    var teamsSubject = BehaviorSubject<TeamsScreenData>(value: .loading)
    var openTeamInfoSubject = BehaviorSubject<TeamScreenData?>(value: nil)
    init(leagueID: Int,
         dataSource: TeamsDataSource = MoyaTeamsDataSource(),
         localDataSource: TeamsDataSource = RealmTeamsDataSource(),
         loadLeaguesUseCase: @escaping loadTeamsUseCaseType = fetchTeams) {
        self.dataSource = dataSource
        self.localDataSource = localDataSource
        self.loadteamsUseCase = loadLeaguesUseCase
        self.leagueID = leagueID
        loadData()
    }
    private func loadData() {
        loadteamsUseCase(leagueID,dataSource,localDataSource).subscribe(onSuccess: {[weak self] leagueScreenData in
            self?.teamsSubject.onNext(leagueScreenData)
            }, onError: { [weak self] error in
                self?.teamsSubject.onNext(.failure(error: "Server Error"))
        }).disposed(by: disposeBage)
    }
    func didSelectRowAt(index: Int ) {
        guard let leaguesScreenState = try? teamsSubject.value(),
            case .success(let teams) = leaguesScreenState,
            FootBallAppConstants.avaliableLeageIds.contains(teams[index].id)
            else {
                return
        }
        openTeamInfoSubject.onNext(teams[index])
    }
}
