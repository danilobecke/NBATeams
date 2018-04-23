//
//  StandingsViewController.swift
//  NBA Teams
//
//  Created by Danilo Becke on 22/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

class StandingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView?

    private let standings: [StandingsCell.Conference] = [.east, .west]
    private var cellsHeightCache: [IndexPath: CGFloat] = [:]
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Standings"
        
        // tableview setup
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.register(UINib(nibName: "CompleteStandingsCell", bundle: nil),
                            forCellReuseIdentifier: "standings")
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "StandingsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let conference = self.standings.get(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell: UITableViewCell
        if let standings = tableview?.dequeueReusableCell(withIdentifier: "standings")
            as? CompleteStandingsCell {
            standings.conference = conference
            cell = standings
            cellsHeightCache[indexPath] = standings.height
        } else {
            cell = CompleteStandingsCell(withConference: conference)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellsHeightCache[indexPath] {
            return height
        } else {
            return 44
        }
    }
    
}
