//
//  CompleteStandingsCell.swift
//  NBA Teams
//
//  Created by Danilo Becke on 23/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

class CompleteStandingsCell: StandingsCell {
    
    override var numberOfTeams: Int {
        return 15
    }
    
    // MARK: - FeedCell overrides
    override var height: CGFloat {
        return 44 * 16
    }
    
    override func didSelect(tableView: UITableView) {
        // NOP
    }
}
