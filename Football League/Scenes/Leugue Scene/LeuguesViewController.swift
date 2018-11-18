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
}

extension LeuguesViewController: LeagesView {
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
        return leagueCell
    }
}

