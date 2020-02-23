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
      typealias loadLeagesUseCaseType = (TeamsDataSource,TeamsDataSource)->(Single<TeamsScreenData>)
      private var loadLeaguesUseCase: loadLeagesUseCaseType
      var leaguesSubject = BehaviorSubject<TeamsScreenData>(value: .loading)
      var openTeamsSubject = BehaviorSubject<Int?>(value: nil)
      init(leagueID: Int,
           dataSource: TeamsDataSource = MoyaTeamsDataSource(),
           localDataSource: TeamsDataSource = RealmTeamsDataSource(),
           loadLeaguesUseCase: @escaping loadLeagesUseCaseType = fetchTeams) {
          self.dataSource = dataSource
          self.localDataSource = localDataSource
          self.loadLeaguesUseCase = loadLeaguesUseCase
           self.leagueID = leagueID
          loadData()
      }
      private func loadData() {
          loadLeaguesUseCase(dataSource,localDataSource).subscribe(onSuccess: {[weak self] leagueScreenData in
              self?.leaguesSubject.onNext(leagueScreenData)
              }, onError: { [weak self] error in
                  self?.leaguesSubject.onNext(.failure(error: "Server Error"))
          }).disposed(by: disposeBage)
      }
      func didSelectRowAt(index: Int ) {
          guard let leaguesScreenState = try? leaguesSubject.value(),
              case .success(let leagues) = leaguesScreenState,
              FootBallAppConstants.avaliableLeageIds.contains(leagues[index].id)
              else {
                  return
          }
          openTeamsSubject.onNext(leagues[index].id)
      }
}
