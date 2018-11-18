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
    @IBOutlet weak var matchCountLabel: UILabel!
    @IBOutlet weak var teamsCountLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        let selectedBackgroundView = UIView.init()
        selectedBackgroundView.backgroundColor = UIColor.lightGray
        self.selectedBackgroundView = selectedBackgroundView
    }
}
