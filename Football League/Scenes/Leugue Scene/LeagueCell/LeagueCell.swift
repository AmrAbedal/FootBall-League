//
//  LeagueCell.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    static let identifier = "LeagueCell"
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
    func configure(league: LeagueScreenData) {
       leagueNameLabel.text = league.name
       containerView.backgroundColor = league.hasMoreInfo ? #colorLiteral(red: 0.3661011159, green: 0.6288253665, blue: 0.815112412, alpha: 1) : #colorLiteral(red: 0.3353716135, green: 0.3788660169, blue: 0.3997601271, alpha: 1)
    }
}
