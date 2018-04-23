//
//  AllTeamsViewController.swift
//  NBA Teams
//
//  Created by Danilo Becke on 22/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

class AllTeamsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AllTeamsDelegate {
    
    // MARK: - AllTeamsDelegate
    func didFail() {
        
    }
    
    func didSucceed(withTeams teams: AllTeams) {
        allTeams = teams.teams.config.flatMap { $0 }
    }
    
    // MARK: - IBOutlets & Vars
    @IBOutlet weak var tableView: UITableView?
    
    private var selected: IndexPath?
    
    private var allTeams: [Team] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private var cellsHeightCache: [IndexPath: CGFloat] = [:]

    // MARK: - View lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "AllTeamsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "All Teams"
        
        AllTeamsBO(withDelegate: self).getTeams()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        tableView?.register(UINib(nibName: "AllTeamsCell", bundle: nil), forCellReuseIdentifier: "team")
    }
    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let team = allTeams.get(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell: AllTeamsCell
        if let teamCell = tableView.dequeueReusableCell(withIdentifier: "team") as? AllTeamsCell {
            teamCell.team = team
            teamCell.expanded = indexPath == selected
            cell = teamCell
        } else {
            cell = AllTeamsCell(withTeam: team)
        }
        
        cellsHeightCache[indexPath] = cell.height
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = selected == indexPath ? nil : indexPath
        (tableView.cellForRow(at: indexPath) as? FeedCell)?.didSelect(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellsHeightCache[indexPath] {
            return height
        } else {
            return 44
        }
    }
}
