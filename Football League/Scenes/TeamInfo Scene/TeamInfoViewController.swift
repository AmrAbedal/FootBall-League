//
//  TeamInfoViewController.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

protocol TeamInfoView: class {
       func updateData()
}

class TeamInfoViewController: UIViewController {

    var leagueId: Int!
    let presenter: TeamInfoPresenter = DefaultTeamInfoPresenter()
    @IBOutlet weak var teamsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTeamTable()
        presenter.attach(view: self, andLeagueId: leagueId)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private func setupTeamTable() {
        teamsTableView.rowHeight = UITableViewAutomaticDimension
        teamsTableView.estimatedRowHeight = 150
    }
}

extension TeamInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numOfTeams()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teamCell = tableView.dequeueReusableCell(withIdentifier: TeamCell.identifier) as! TeamCell
        teamCell.teamImageView.sd_setImage(with: URL(string: presenter.teamLogoUrlForIndex(index: indexPath.row)), placeholderImage: nil)
        
        teamCell.teamNameLabel.text = presenter.teamNameForIndex(index: indexPath.row)
        teamCell.teamShotNameLabel.text = presenter.teamShortNameForIndex(index: indexPath.row)
        return teamCell
    }
}

extension TeamInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension TeamInfoViewController: TeamInfoView {
    func updateData() {
        teamsTableView.reloadData()
    }
}

