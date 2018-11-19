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
    func attach(view: TeamsView)
    func viewDidLoad()
    func numOfLeages() -> Int
    func leagueNameForIndex(index: Int) -> String
}

class DefaultTeamsPresenter {
    private var teams : [Team] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: TeamsView?
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

extension DefaultTeamsPresenter: TeamsPresenter {
    
    func attach(view: TeamsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        
        guard let url = URL.init(string: AppUrls.leagues) else {
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
    
    func leagueNameForIndex(index: Int) -> String {
        return teams[index].name ?? ""
    }
    
    func numOfLeages() -> Int {
        return teams.count
    }
}

