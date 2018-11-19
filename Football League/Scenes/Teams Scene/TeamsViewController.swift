//
//  TeamsViewController.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

protocol TeamsView: class {
    func updateData()
}

class TeamsViewController: UIViewController {

    @IBOutlet weak var teamsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         setupTeamTable()
        // Do any additional setup after loading the view.
    }
    private func setupTeamTable() {
        teamsTableView.rowHeight = UITableViewAutomaticDimension
        teamsTableView.estimatedRowHeight = 150
    }
}
extension TeamsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teamCell = tableView.dequeueReusableCell(withIdentifier: TeamCell.identifier) as! TeamCell
        teamCell.teamImageView.image = UIImage.init()
        teamCell.teamNameLabel.text = "Liverpool"
        teamCell.teamShotNameLabel.text = "LPC"
        return teamCell
    }
}

extension TeamsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
