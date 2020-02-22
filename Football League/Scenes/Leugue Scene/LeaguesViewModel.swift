//
//  LeaguesViewModel.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift

enum LeaguesScreenData {
    case success([League])
    case loading
    case failure(error:String)
}

class LeaguesViewModel {
    var leaguesSubject = BehaviorSubject<LeaguesScreenData>(value: .loading)

}
