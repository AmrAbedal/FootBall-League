//
//  TeamInfoPresnter.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

protocol TeamInfoPresenter: class {
    func teamName() -> String?
    func teamShortName() -> String?
    func teamLogoUrl() -> String
    func attach(view: TeamInfoView)
    func viewDidLoad(withTeam team: Team?)
    func numOfPlayers() -> Int
    func playerNameForIndex(index: Int) -> String?
    func playerPositionForIndex(index: Int) -> String?
    func playerNationalityForIndex(index: Int) -> String?
}

class DefaultTeamInfoPresenter {
    private var team: Team?
    private var players : [Player] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: TeamInfoView?
    private let localStorage = DataBaseManager.shared
    
}

extension DefaultTeamInfoPresenter: TeamInfoPresenter {
    func teamName() -> String? {
        return team?.name
    }
    
    func teamShortName() -> String? {
        return team?.shortName
    }
    
    func teamLogoUrl() -> String {
        return team?.crestUrl ?? ""
    }
    
    
    func playerPositionForIndex(index: Int) -> String? {
        return players[index].position
    }
    
    func playerNationalityForIndex(index: Int) -> String? {
        return players[index].nationality
    }
    
    func attach(view: TeamInfoView) {
        self.view = view
    }
    
    func viewDidLoad(withTeam team: Team?) {
        guard let team = team else {
            print("show error message")
            return
        }
        
        self.team = team
        view?.updateData()
        guard let url = URL.init(string: AppUrls.teamInfoUrl(ofTeamId: team.id)) else {
            print("show Error Message")
            return
        }
        
        var reguest = URLRequest.init(url: url )
        reguest.addValue(FootBallAppConstants.token, forHTTPHeaderField: FootBallAppConstants.tokenName)
        
        networkmanager.fetchData( withUrlRequest: reguest, andResponceType: PlayersResult.self, andCompletion: { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            if let teamInfo = result as? PlayersResult {
                print(teamInfo.id)
                strongSelf.players = Array(teamInfo.players)
                strongSelf.addPlayrsToRealm(players: strongSelf.players, withTeamId: team.id)
                
                strongSelf.view?.updateData()
            }
        }) {[weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.fetchPlayerFromLocalStorage(withTeamId: team.id )
        }
    }
    func fetchPlayerFromLocalStorage(withTeamId teamId: Int) {
        let players = localStorage.getObjects(ofType: Player.self).filter({$0.teamID == teamId})
        if !players.isEmpty  {
            self.players = players
            view?.updateData()
        }
        else {
            print("show error message??")
        }
    }
    
    private func addPlayrsToRealm(players: [Player] , withTeamId teamId: Int) {
        for player in players {
            player.teamID = teamId
            localStorage.addOrUpdateObject(object: player)
        }
    }
    
    func playerNameForIndex(index: Int) -> String? {
        return players[index].name 
    }
    
    func numOfPlayers() -> Int {
        return players.count
    }
}
