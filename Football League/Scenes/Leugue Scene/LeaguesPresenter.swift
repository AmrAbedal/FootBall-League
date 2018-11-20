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
    func leagueNameForIndex(index: Int) -> String?
    func didSelectItemAtIndex(index: Int)
    func backGroundColorForIndex(index: Int) -> UIColor
}

class DefaultLeaguesPresenter {
    private var leagues : [League] = []
    private let networkmanager = NetworkManager.shared
    private weak var view: LeagesView?
    private let localStorage = DataBaseManager.shared
    
    private func loadData() {
        guard let url = URL.init(string: AppUrls.leagues) else {
            print("Error in loading data from Server")
            return
        }
        
        var reguest = URLRequest.init(url: url )
        reguest.addValue(FootBallAppConstants.token, forHTTPHeaderField: FootBallAppConstants.tokenName)
        
        networkmanager.fetchData( withUrlRequest: reguest, andResponceType: LeaguesResult.self, andCompletion: { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            if let leages = result as? LeaguesResult {
                print(leages.count)
                strongSelf.leagues = Array(leages.leagues)
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
    
    private func fetchDataFromLocalStorage() {
        let leagues = localStorage.getObjects(ofType: League.self)
        if !leagues.isEmpty  {
            self.leagues = leagues
            view?.updateData()
        }
        else {
            print("please open Wifi OR Data")
        }
    }
    
    private func addObjectsToRealm(objects: [Object]) {
        for object in objects {
            localStorage.addOrUpdateObject(object: object)
        }
    }
   
}


extension DefaultLeaguesPresenter: LeaguesPresenter {
    func backGroundColorForIndex(index: Int) -> UIColor {
        if FootBallAppConstants.avaliableLeageIds.contains(leagues[index].id) {
            return UIColor.purple
        }
        else {
            return UIColor.cyan
        }
    }
    
    func didSelectItemAtIndex(index: Int) {
        guard FootBallAppConstants.avaliableLeageIds.contains(leagues[index].id) else {
            return
        }
        view?.presentTeamsViewController(withLeagueId:leagues[index].id )
    }
    
    func attach(view: LeagesView) {
        self.view = view
    }
    
    func viewDidLoad() {
       loadData()
    }
    
    func leagueNameForIndex(index: Int) -> String? {
        return leagues[index].name
    }
    
    func numOfLeages() -> Int {
        return leagues.count
    }
}

