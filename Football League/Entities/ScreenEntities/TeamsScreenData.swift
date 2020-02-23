//
//  TeamsScreenData.swift
//  Football League
//
//  Created by Amr AbdelWahab on 2/23/20.
//  Copyright © 2020 Arabia-IT. All rights reserved.
//

import Foundation

enum TeamsScreenData {
    case success([TeamScreenData])
    case loading
    case failure(error:String)
}
