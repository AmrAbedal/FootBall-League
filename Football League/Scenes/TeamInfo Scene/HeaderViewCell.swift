//
//  HeaderViewCell.swift
//  Football League
//
//  Created by Other user on 11/20/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
static let identifier = "HeaderViewCell"
    @IBOutlet weak var teaminfoLabel: UILabel!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
