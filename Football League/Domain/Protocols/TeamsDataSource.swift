//
//  TeamsDataSource.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/23/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation
import RxSwift

protocol TeamsDataSource {
    func getLeagues() -> Single<TeamsResult>
}
