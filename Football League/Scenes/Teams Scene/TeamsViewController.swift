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
     func presentTeamInfoViewController(withLeagueId leagueId: Int)
}

class TeamsViewController: UIViewController {
    var leagueId: Int!
    let presenter: TeamsPresenter = DefaultTeamsPresenter()
    @IBOutlet weak var teamsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         setupTeamTable()
        presenter.attach(view: self, andLeagueId: leagueId)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private func setupTeamTable() {
        title = "Teams"
        teamsTableView.rowHeight = UITableViewAutomaticDimension
        teamsTableView.estimatedRowHeight = 150
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
        presenter.didSelectItemAtIndex(index: indexPath.row)
    }
}

extension TeamsViewController: TeamsView {
    func presentTeamInfoViewController(withLeagueId leagueId: Int) {
        perform(segue: "TeamInfoViewController") { (teamsViewController: TeamInfoViewController) in
            teamsViewController.teamId = leagueId
    }
    }
    func updateData() {
        teamsTableView.reloadData()
    }
}
