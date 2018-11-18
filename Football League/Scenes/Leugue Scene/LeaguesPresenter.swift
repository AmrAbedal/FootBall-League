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
}

class DefaultLeaguesPresenter: LeaguesPresenter {
    
    private var leagues = List<League>()
    
    let networkmanager = NetworkManager.shared
    
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
                strongSelf.leagues = leages.competitions
//                for league in leages.competitions {
//                    print(league.name)
//                }
                strongSelf.view?.updateData()
            }
        }) {
            
            print ("error")
        }
        
    }
    
    private weak var view: LeagesView?
    
    func attach(view: LeagesView) {
        self.view = view
    }
    
   
    
}

