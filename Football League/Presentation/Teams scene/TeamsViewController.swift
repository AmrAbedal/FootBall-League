//
//  TeamsViewController.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
 
class TeamsViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private var teams: [TeamScreenData] = []
    var leagueId: Int?
    private lazy var teamsViewModel: TeamsViewModel = {
        return TeamsViewModel(leagueID: leagueId ?? 0 )
    }()
    @IBOutlet weak var teamsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTeamsTable()
       
    }
    private func setupTeamsTable() {
        title = "Teams"
        registerTeamsTableCells()
        teamsTableView.rowHeight = UITableView.automaticDimension
        teamsTableView.estimatedRowHeight = 150
    }
    private func registerTeamsTableCells() {
        let teamCellNib = UINib(nibName: TeamCell.identifier, bundle: nil)
        teamsTableView.register(teamCellNib, forCellReuseIdentifier: TeamCell.identifier)
    }
    private func setupLeagesSubscribers() {
         teamsViewModel.leaguesSubject.subscribe({
             [weak self] event in
             if let element = event.element {
                 self?.handleLeaguesScreenData(screenData: element)
             }
         }).disposed(by: disposeBag)
         teamsViewModel.openTeamsSubject.subscribe({ [weak self]
             event in
             if let element = event.element , let leagueID = element {
//                 self?.presentTeamInfoViewController(withTeam: leagueID)
             }
         }).disposed(by: disposeBag)
     }
     
     private func handleLeaguesScreenData(screenData: TeamsScreenData) {
         switch screenData {
         case .loading: break
         case .success(let leagues): handleLeagues(leagues: leagues)
         case .failure: break
         }
     }
     
     private func handleLeagues(leagues: [TeamScreenData]) {
         self.teams = leagues
         teamsTableView.reloadData()
     }
    
     func updateData() {
         teamsTableView.reloadData()
     }
}

extension TeamsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teamCell = tableView.dequeueReusableCell(withIdentifier: TeamCell.identifier) as! TeamCell
//        teamCell.teamImageView.sd_setImage(with: URL(string: presenter.teamLogoUrlForIndex(index: indexPath.row)), placeholderImage: nil)
//
//        teamCell.teamNameLabel.text = presenter.teamNameForIndex(index: indexPath.row)
//        teamCell.teamShotNameLabel.text = presenter.teamShortNameForIndex(index: indexPath.row)
        return teamCell
    }
    func presentTeamInfoViewController(withTeam team: Team) {
        perform(segue: Segues.TeamInfoViewController.rawValue) { (teamsViewController: TeamInfoViewController) in
            teamsViewController.team = team
        }
    }
}

