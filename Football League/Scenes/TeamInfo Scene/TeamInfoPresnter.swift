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
    func attach(view: TeamInfoView , andTeamId leagueId: Int)
    func viewDidLoad()
    func numOfTeams() -> Int
    func playerNameForIndex(index: Int) -> String
    func playerPositionForIndex(index: Int) -> String
    func playerNationalityForIndex(index: Int) -> String
}

class DefaultTeamInfoPresenter {
    private var teamID: Int!
    private var players : [Player] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: TeamInfoView?
    private let localStorage = DataBaseManager.shared
    func fetchDataFromLocalStorage() {
        let players = localStorage.getData(ofType: Player.self)
        if !players.isEmpty  {
            self.players = players
            view?.updateData()
        }
        else {
            print("show error message??")
        }
    }
    private func addObjectsToRealm(objects: [Object]) {
        for object in objects {
            localStorage.addObject(object: object)
        }
    }
}

extension DefaultTeamInfoPresenter: TeamInfoPresenter {
    
    func playerPositionForIndex(index: Int) -> String {
        return players[index].position ?? ""
    }
    
    func playerNationalityForIndex(index: Int) -> String {
        return players[index].nationality ?? ""
    }
    
    func attach(view: TeamInfoView, andTeamId teamId: Int) {
        self.view = view
        self.teamID = teamId
    }
    
    func viewDidLoad() {
        
        guard let url = URL.init(string: AppUrls.teamInfoUrl(ofTeamId: teamID)) else {
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
                strongSelf.players = Array(teamInfo.squad)
                strongSelf.addObjectsToRealm(objects: strongSelf.players)
                
                strongSelf.view?.updateData()
            }
        }) {[weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.fetchDataFromLocalStorage()
        }
    }
    
    func playerNameForIndex(index: Int) -> String {
        return players[index].name ?? ""
    }
    
    func numOfTeams() -> Int {
        return players.count
    }
}
