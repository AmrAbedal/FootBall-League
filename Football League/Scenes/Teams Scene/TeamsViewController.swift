//
//  TeamsViewController.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit
import SDWebImage

protocol TeamsView: class {
    func updateData()
    func presentTeamInfoViewController(withTeam team: Team)
}

class TeamsViewController: UIViewController {
    
    var leagueId: Int?
    let presenter: TeamsPresenter = DefaultTeamsPresenter()
    @IBOutlet weak var teamsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTeamsTable()
        presenter.attach(view: self)
        presenter.viewDidLoad(withLeagueId : leagueId)
        // Do any additional setup after loading the view.
    }
    private func setupTeamsTable() {
        title = "Teams"
        registerTeamsTableCells()
        teamsTableView.rowHeight = UITableViewAutomaticDimension
        teamsTableView.estimatedRowHeight = 150
    }
    private func registerTeamsTableCells() {
        
        let teamCellNib = UINib(nibName: TeamCell.identifier, bundle: nil)
        teamsTableView.register(teamCellNib, forCellReuseIdentifier: TeamCell.identifier)
    }
}

extension TeamsViewController: UITableViewDataSource {
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

extension TeamsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectTeamAtIndex(index: indexPath.row)
    }
}

extension TeamsViewController: TeamsView {
    func presentTeamInfoViewController(withTeam team: Team) {
        perform(segue: Segues.TeamInfoViewController.rawValue) { (teamsViewController: TeamInfoViewController) in
            teamsViewController.team = team
        }
    }
    
    func updateData() {
        teamsTableView.reloadData()
    }
}
