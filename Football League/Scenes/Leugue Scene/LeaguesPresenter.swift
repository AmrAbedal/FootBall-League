//
//  LeaguesPresenter.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import  RealmSwift

protocol LeaguesPresenter: class {
    func attach(view: LeagesView)
    func viewDidLoad()
    func numOfLeages() -> Int
    func leagueNameForIndex(index: Int) -> String
    func didSelectItemAtIndex(index: Int)
    func backGroundColorForIndex(index: Int) -> UIColor
}

class DefaultLeaguesPresenter {
    private var leagues : [League] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: LeagesView?
    private let localStorage = DataBaseManager.shared
    func fetchDataFromLocalStorage() {
        let leagues = localStorage.getData(ofType: League.self)
        if !leagues.isEmpty  {
            self.leagues = leagues
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

extension DefaultLeaguesPresenter: LeaguesPresenter {
    func backGroundColorForIndex(index: Int) -> UIColor {
        if Constants.avaliableLeageIds.contains(leagues[index].id) {
            return UIColor.purple
        }
        else {
            return UIColor.cyan
        }
    }
    
    func didSelectItemAtIndex(index: Int) {
        guard Constants.avaliableLeageIds.contains(leagues[index].id) else {
            return
        }
        view?.presentTeamsViewController(withLeagueId:leagues[index].id )
    }
    
    
    
    
    func attach(view: LeagesView) {
        self.view = view
    }
    
    func viewDidLoad() {
        
        guard let url = URL.init(string: AppUrls.leagues) else {
            return
        }
        
        var reguest = URLRequest.init(url: url )
        reguest.addValue(Constants.token, forHTTPHeaderField: Constants.tokenName)
        
        networkmanager.fetchData( withurlRequest: reguest, andResponceType: Leagues.self, andCompletion: { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            if let leages = result as? Leagues {
                print(leages.count)
                strongSelf.leagues = Array(leages.competitions)
                strongSelf.addObjectsToRealm(objects: strongSelf.leagues)
                
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
        return leagues[index].name ?? ""
    }
    
    func numOfLeages() -> Int {
        return leagues.count
    }
}

