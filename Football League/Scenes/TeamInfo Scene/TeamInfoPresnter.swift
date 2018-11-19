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
    func attach(view: TeamInfoView , andLeagueId leagueId: Int)
    func viewDidLoad()
    func numOfTeams() -> Int
    func teamNameForIndex(index: Int) -> String
    func teamShortNameForIndex(index: Int) -> String
    func teamLogoUrlForIndex(index: Int) -> String
}

class DefaultTeamInfoPresenter {
    private var leagueId: Int!
    private var teams : [Team] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: TeamInfoView?
    private let localStorage = DataBaseManager.shared
    func fetchDataFromLocalStorage() {
        let leagues = localStorage.getData(ofType: Team.self)
        if !leagues.isEmpty  {
            self.teams = leagues
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
    
    func teamShortNameForIndex(index: Int) -> String {
        return teams[index].shortName ?? ""
    }
    
    func teamLogoUrlForIndex(index: Int) -> String {
        return teams[index].crestUrl ?? ""
    }
    
    func attach(view: TeamInfoView, andLeagueId leagueId: Int) {
        self.view = view
        self.leagueId = leagueId
    }
    
    func viewDidLoad() {
        
        guard let url = URL.init(string: AppUrls.teamUrlOfLeageId(leagueid: leagueId)) else {
            return
        }
        
        var reguest = URLRequest.init(url: url )
        reguest.addValue(Constants.token, forHTTPHeaderField: Constants.tokenName)
        
        networkmanager.fetchData( withurlRequest: reguest, andResponceType: Teams.self, andCompletion: { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            if let teams = result as? Teams {
                print(teams.count)
                strongSelf.teams = Array(teams.teams)
                strongSelf.addObjectsToRealm(objects: strongSelf.teams)
                
                strongSelf.view?.updateData()
            }
        }) {[weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.fetchDataFromLocalStorage()
        }
    }
    
    func teamNameForIndex(index: Int) -> String {
        return teams[index].name ?? ""
    }
    
    func numOfTeams() -> Int {
        return teams.count
    }
}
