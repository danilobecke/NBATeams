//
//  MainFeedViewController.swift
//  NBA Teams
//
//  Created by Danilo Becke on 18/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StandingsDelegate {
    
    func didSucceed(withStandings s: Standings) {
        
    }
    
    func didFail() {
        
    }

    @IBOutlet weak var tableView: UITableView?
    
    private var feed: [UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StandingsBO(withDelegate: self).getStandings()
        
        // tableview setup
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = feed.get(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (feed.get(at: indexPath.row) as? FeedCell)?.didSelect(tableView: tableView)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else {
            return 0
        }
        
        return CGFloat(cell.height)
    }
}
