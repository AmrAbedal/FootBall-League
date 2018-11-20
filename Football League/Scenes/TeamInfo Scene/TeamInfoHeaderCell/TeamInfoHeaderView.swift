//
//  TeamInfoHeaderViewCell.swift
//  Football League
//
//  Created by Other user on 11/20/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

class TeamInfoHeaderView: UITableViewCell {
    static let identifier = "TeamInfoHeaderView"
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamShortNameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
