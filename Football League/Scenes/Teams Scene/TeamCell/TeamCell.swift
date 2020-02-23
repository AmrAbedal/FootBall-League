//
//  TeamCell.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit
import SDWebImage

class TeamCell: UITableViewCell {
    static let identifier = "TeamCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var teamShotNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(team: TeamScreenData) {

        teamImageView.sd_setImage(with: URL(string: team.logo), placeholderImage: nil)
        
        teamNameLabel.text = team.name
        teamShotNameLabel.text = team.shortName
    }
}
