//
//  TeamInfoViewController.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit
import SDWebImage

protocol TeamInfoView: class {
    func updateData()
}

class TeamInfoViewController: UIViewController {
    
    var teamId: Int?
    let presenter: TeamInfoPresenter = DefaultTeamInfoPresenter()
    
    @IBOutlet weak var teamInfoTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTeamTable()
        presenter.attach(view: self)
        presenter.viewDidLoad(withTeamID: teamId)
        // Do any additional setup after loading the view.
    }
    
    private func setupTeamTable() {
        registerTeamTableCells()
        teamInfoTable.rowHeight = UITableViewAutomaticDimension
        teamInfoTable.estimatedRowHeight = 150
    }
    
    private func registerTeamTableCells() {
        let teamInfoHeaderViewNib = UINib(nibName: TeamInfoHeaderView.identifier, bundle: nil)
        teamInfoTable.register(teamInfoHeaderViewNib, forCellReuseIdentifier: TeamInfoHeaderView.identifier)
        
        let playerCellNib = UINib(nibName: PlayerCell.identifier, bundle: nil)
        teamInfoTable.register(playerCellNib, forCellReuseIdentifier: PlayerCell.identifier)
    }
}

extension TeamInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numOfPlayers()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewCell = tableView.dequeueReusableCell(withIdentifier: TeamInfoHeaderView.identifier) as! TeamInfoHeaderView
        headerViewCell.teamNameLabel.text = presenter.teamName()
        headerViewCell.teamShortNameLabel.text = presenter.teamShortName()
        headerViewCell.teamImageView.sd_setImage(with: URL(string: presenter.teamLogoUrl()), placeholderImage: nil)
        return headerViewCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.identifier) as! PlayerCell
        playerCell.playerNameLabel.text = presenter.playerNameForIndex(index: indexPath.row)
        
        playerCell.playerPositionLabel.text = presenter.playerPositionForIndex(index: indexPath.row)
        
        playerCell.playerNationalityLabel.text =  presenter.playerNationalityForIndex(index: indexPath.row)
        return playerCell
    }
}

extension TeamInfoViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension TeamInfoViewController: TeamInfoView {
    func updateData() {
        teamInfoTable.reloadData()
    }
}

