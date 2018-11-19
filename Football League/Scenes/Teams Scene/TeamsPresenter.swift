//
//  TeamsPresenter.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import RealmSwift

protocol TeamsPresenter: class {
    func attach(view: TeamsView , andLeagueId leagueId: Int)
    func viewDidLoad()
    func numOfTeams() -> Int
    func teamNameForIndex(index: Int) -> String
    func teamShortNameForIndex(index: Int) -> String
    func teamLogoUrlForIndex(index: Int) -> String
    func didSelectItemAtIndex(index: Int)
}

class DefaultTeamsPresenter {
    private var leagueId: Int!
    private var teams : [Team] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: TeamsView?
    
    private let localStorage = DataBaseManager.shared
    func fetchDataFromLocalStorage() {
        let leagues = localStorage.getData(ofType: Team.self).filter({$0.leagueId == self.leagueId})
        if !leagues.isEmpty  {
            self.teams = leagues
            view?.updateData()
        }
        else {
            print("show error message??")
        }
    }
    private func addTeamsToRealm(teams: [Team]) {
        for team in teams {
            team.leagueId = self.leagueId
            localStorage.addObject(object: team)
        }
    }
}

extension DefaultTeamsPresenter: TeamsPresenter {
    func didSelectItemAtIndex(index: Int) {
        view?.presentTeamInfoViewController(withLeagueId: teams[index].id)
    }
    
    func teamShortNameForIndex(index: Int) -> String {
        return teams[index].shortName ?? ""
    }
    
    func teamLogoUrlForIndex(index: Int) -> String {
        return teams[index].crestUrl ?? ""
    }
    
    func attach(view: TeamsView, andLeagueId leagueId: Int) {
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
                strongSelf.addTeamsToRealm(teams: strongSelf.teams)
                
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

