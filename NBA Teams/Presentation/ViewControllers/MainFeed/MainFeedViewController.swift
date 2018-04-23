//
//  MainFeedViewController.swift
//  NBA Teams
//
//  Created by Danilo Becke on 18/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private enum CellType {
        case standings(style: StandingsCell.Conference)
        case segue(title: String)
    }
    
    @IBOutlet weak var tableView: UITableView?
    
    private let cells: [CellType] = [.standings(style: .east),
                                     .standings(style: .west),
                                     .segue(title: "All Teams")
                                    ]
    private var cellsHeightCache: [IndexPath: CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NBA"
        self.customizeNavigationBar()
        
        // tableview setup
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UINib(nibName: "StandingsCell", bundle: nil), forCellReuseIdentifier: "standings")
    }
    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = cells.get(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .standings(let conference):
            let cell: StandingsCell
            if let standings = tableView.dequeueReusableCell(withIdentifier: "standings") as? StandingsCell {
                standings.conference = conference
                cell = standings
            } else {
                cell = StandingsCell(withConference: conference)
            }
            cellsHeightCache[indexPath] = cell.height
            return cell
        case .segue(let title):
            let cell = segueCell(withTitle: title)
            cellsHeightCache[indexPath] = 44
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FeedCell {
            cell.didSelect(tableView: tableView)
        } else {
            push(AllTeamsViewController())
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellsHeightCache[indexPath] {
            return height
        } else {
            return 44
        }
    }
    
    // MARK: - Internal work
    private func customizeNavigationBar() {        
        guard let navBar = navigationController?.navigationBar,
            let gradientImage = UIColor.customGradientImage(withFrame: navBar.bounds) else {
                return
        }
        
        let titleColor = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        if #available(iOS 11.0, *) {
            navBar.prefersLargeTitles = true
            navBar.largeTitleTextAttributes = titleColor
        }
        
        navBar.barTintColor = UIColor(patternImage: gradientImage)
        
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = titleColor
    }
    
    private func segueCell(withTitle title: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "segue")
        cell.textLabel?.text = title
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}
