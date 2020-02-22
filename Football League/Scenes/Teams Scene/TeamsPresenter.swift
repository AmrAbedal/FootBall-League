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
    func attach(view: TeamsView )
    func viewDidLoad(withLeagueId leagueid: Int?)
    func numOfTeams() -> Int
    func teamNameForIndex(index: Int) -> String?
    func teamShortNameForIndex(index: Int) -> String?
    func teamLogoUrlForIndex(index: Int) -> String
    func didSelectTeamAtIndex(index: Int)
}

class DefaultTeamsPresenter {
    
    private var teams : [Team] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: TeamsView?
    private let localStorage = DataBaseManager.shared
    
    func fetchTeamsFromLocalStorage(withLeagueId leagueID: Int) {
        let leagues = localStorage.getObjects(ofType: Team.self).filter({$0.leagueId == leagueID})
        if !leagues.isEmpty  {
            self.teams = Array(leagues)
            view?.updateData()
        }
        else {
            print("show error message??")
            
        }
    }
    
    private func addTeamsToRealm(teams: [Team], andLeagueId leagueID: Int) {
        for team in teams {
            team.leagueId = leagueID
            localStorage.addOrUpdateObject(object: team)
        }
    }
}

extension DefaultTeamsPresenter: TeamsPresenter {
    
    func didSelectTeamAtIndex(index: Int) {
        view?.presentTeamInfoViewController(withTeam: teams[index])
    }
    
    func teamShortNameForIndex(index: Int) -> String? {
        return teams[index].shortName
    }
    
    func teamLogoUrlForIndex(index: Int) -> String {
        return teams[index].crestUrl ?? ""
    }
    
    func attach(view: TeamsView) {
        self.view = view
       
    }
    
    func viewDidLoad(withLeagueId leagueId: Int?) {
        guard let leagueID = leagueId else {
            print("Error in Fetching Data From Server")
            return
        }
        
        guard let url = URL.init(string: AppUrls.teamUrlOfLeageId(leagueid: leagueID)) else {
               print("Error in Fetching Data From Server")
            return
        }
        
        var reguest = URLRequest.init(url: url )
        reguest.addValue(FootBallAppConstants.token, forHTTPHeaderField: FootBallAppConstants.tokenName)
        
        networkmanager.fetchData( withUrlRequest: reguest, andResponceType: TeamsResult.self, andCompletion: { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            if let teams = result as? TeamsResult {
                print(teams.count)
                strongSelf.teams = Array(teams.teams)
                strongSelf.addTeamsToRealm(teams: strongSelf.teams, andLeagueId: leagueID)
                
                strongSelf.view?.updateData()
            }
        }) {[weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.fetchTeamsFromLocalStorage(withLeagueId: leagueID)
        }
    }
    
    func teamNameForIndex(index: Int) -> String? {
        return teams[index].name 
    }
    
    func numOfTeams() -> Int {
        return teams.count
    }
}

