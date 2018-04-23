//
//  StandingsCell.swift
//  NBA Teams
//
//  Created by Danilo Becke on 18/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

class StandingsCell: UITableViewCell, FeedCell, StandingsDelegate, AllTeamsDelegate {
    
    enum Conference: String {
        case east = "Eastern"
        case west = "Western"
    }
    
    // MARK: - Standings & AllTeams Delegate
    func didFail() {}
    
    func didSucceed(withStandings standings: Standings) {
        switch conference {
        case .east:
            self.standings = Array(standings.league.standard.conference.east.prefix(8)).sorted {
                (first, second) -> Bool in
                return first.confRank < second.confRank
            }
        case .west:
            self.standings = Array(standings.league.standard.conference.west.prefix(8)).sorted {
                (first, second) -> Bool in
                return first.confRank < second.confRank
            }
        }
        AllTeamsBO(withDelegate: self).getTeams()
    }
    
    func didSucceed(withTeams allTeams: AllTeams) {
        for team in allTeams.teams.config {
            teamsList[team.teamId] = team.tricode
        }
        updateTeams()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var conferenceLabel: UILabel?
    @IBOutlet var teamStackViews: [UIStackView]?
    private var teamStacks: [UIStackView] {
        return teamStackViews?.sorted(by: {
            $0.tag < $1.tag
        }) ?? []
    }

    // MARK: - FeedCell
    var height: CGFloat {
        return 44*9
    }
    
    func didSelect(tableView: UITableView) {
        push(StandingsViewController())
    }
    
    // MARK: - Vars
    var conference: Conference = .east {
        didSet {
            updateInterface()
            StandingsBO(withDelegate: self).getStandings()
        }
    }
    
    private var standings: [TeamStandings] = []
    
    private var teamsList: [String: String] = [:]
    
    // MARK: - Lifecycle
    init(withConference conference: Conference) {
        self.conference = conference
        super.init(style: .default, reuseIdentifier: "standings")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Interface updates
    private func updateInterface() {
        self.conferenceLabel?.text = conference.rawValue
        self.conferenceLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private func updateTeams() {
        for (i, team) in standings.enumerated() {
            guard let stack = teamStacks.get(at: i) else {
                continue
            }
            for (item, view) in stack.arrangedSubviews.enumerated() {
                guard let label = view as? UILabel else {
                    continue
                }
                switch item {
                case 0:
                    label.text = team.confRank
                case 1:
                    label.text = teamsList[team.teamId]
                case 2:
                    label.text = team.win
                case 3:
                    label.text = team.loss
                case 4:
                    label.text = team.winPercentage
                case 5:
                    label.text = "\(team.lastTenWin)-\(team.lastTenLoss)"
                default:
                    continue
                }
            }
        }
    }
}
