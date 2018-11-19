//
//  ViewController.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

protocol LeagesView: class  {
    func updateData()
    func presentTeamsViewController(withLeagueId leagueId: Int)
}

class LeuguesViewController: UIViewController {
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
    private var presenter: LeaguesPresenter = DefaultLeaguesPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeaguesTableview()
        presenter.attach(view: self)
        presenter.viewDidLoad()
    }
    private func setupLeaguesTableview() {
        leaguesTableView.estimatedRowHeight = 100
        leaguesTableView.rowHeight = UITableViewAutomaticDimension
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let identifier = segue.identifier else { return }
//        switch identifier {
//        case "TeamsViewController": let teamsViewController  = segue.destination as! TeamsViewController
//        teamsViewController.leagueId = presenter.
//        default:
//            break
//        }
//    }
}

extension LeuguesViewController: LeagesView {
    func presentTeamsViewController(withLeagueId leagueId: Int) {
        perform(segue: "TeamsViewController") { (teamsViewController: TeamsViewController) in
            teamsViewController.leagueId = leagueId
        }
    }
    func updateData() {
        print("data updated successfully")
        leaguesTableView.reloadData()
    }
}

extension LeuguesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return presenter.numOfLeages()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leagueCell = tableView.dequeueReusableCell(withIdentifier: LeagueCell.identifier) as! LeagueCell
        leagueCell.leagueNameLabel.text = presenter.leagueNameForIndex(index: indexPath.row)
        leagueCell.containerView.backgroundColor = presenter.backGroundColorForIndex(index: indexPath.row)
        return leagueCell
    }
}

extension LeuguesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItemAtIndex(index: indexPath.row)
    }
}

