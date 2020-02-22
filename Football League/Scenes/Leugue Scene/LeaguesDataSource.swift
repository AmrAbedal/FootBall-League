//
//  LeaguesDataSource.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/22/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol LeaguesDataSource {
    func getLeagues() -> Single<LeaguesResult>
    
}

