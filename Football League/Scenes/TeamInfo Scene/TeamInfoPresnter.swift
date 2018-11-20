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
    func viewDidLoad(withTeamID teamId: Int?)
    func numOfPlayers() -> Int
    func playerNameForIndex(index: Int) -> String?
    func playerPositionForIndex(index: Int) -> String?
    func playerNationalityForIndex(index: Int) -> String?
}

class DefaultTeamInfoPresenter {
    private var teamInfo: TeamInfo?
    private var players : [Player] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: TeamInfoView?
    private let localStorage = DataBaseManager.shared
    
  
}

extension DefaultTeamInfoPresenter: TeamInfoPresenter {
    func teamName() -> String? {
        return teamInfo?.name
    }
    
    func teamShortName() -> String? {
        return teamInfo?.shortName
    }
    
    func teamLogoUrl() -> String {
        return teamInfo?.crestUrl ?? ""
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
    
    func viewDidLoad(withTeamID teamID: Int?) {
        guard let teamID = teamID else {
            print("show error message")
            return
        }
        guard let url = URL.init(string: AppUrls.teamInfoUrl(ofTeamId: teamID)) else {
            print("show Error Message")
            return
        }
        
        var reguest = URLRequest.init(url: url )
        reguest.addValue(Constants.token, forHTTPHeaderField: Constants.tokenName)
        
        networkmanager.fetchData( withurlRequest: reguest, andResponceType: TeamInfo.self, andCompletion: { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            if let teamInfo = result as? TeamInfo {
                print(teamInfo.id)
                strongSelf.teamInfo = teamInfo
                strongSelf.players = Array(teamInfo.squad)
                strongSelf.addPlayrsToRealm(players: strongSelf.players, withTeamId: teamID)
                
                strongSelf.view?.updateData()
            }
        }) {[weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.fetchPlayerFromLocalStorage(withTeamId: teamID )
        }
    }
    func fetchPlayerFromLocalStorage(withTeamId teamId: Int) {
        let players = localStorage.getData(ofType: Player.self).filter({$0.teamID == teamId})
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
            localStorage.addObject(object: player)
        }
    }
    
    func playerNameForIndex(index: Int) -> String? {
        return players[index].name 
    }
    
    func numOfPlayers() -> Int {
        return players.count
    }
}
