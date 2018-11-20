//
//  PlayerCell.swift
//  Football League
//
//  Created by Arabia-IT on 11/19/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
static let identifier = "PlayerCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerNationalityLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
