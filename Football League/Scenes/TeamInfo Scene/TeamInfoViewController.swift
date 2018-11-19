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

    var teamId: Int!
    let presenter: TeamInfoPresenter = DefaultTeamInfoPresenter()
    
    @IBOutlet weak var playerTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTeamTable()
        presenter.attach(view: self, andTeamId: teamId)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private func setupTeamTable() {
        playerTable.rowHeight = UITableViewAutomaticDimension
        playerTable.estimatedRowHeight = 150
    }
}

extension TeamInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numOfTeams()
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
        playerTable.reloadData()
    }
}

