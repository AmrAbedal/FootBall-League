//
//  LeagueCell.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {
  static let identifier = "leagueCell"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
