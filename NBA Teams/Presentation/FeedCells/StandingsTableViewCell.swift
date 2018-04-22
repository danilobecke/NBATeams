//
//  StandingsTableViewCell.swift
//  NBA Teams
//
//  Created by Danilo Becke on 18/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

class StandingsTableViewCell: UITableViewCell, FeedCell {

    enum Style {
        case complete
        case east
        case west
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    var height: Float {
        return 0
    }
    
    private let style: Style
    
    init(withStyle style: Style) {
        self.style = style
        super.init(style: .default, reuseIdentifier: "standings")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("[StandingsCell] style must be valid!")
    }
    
    func didSelect(tableView: UITableView) {
        // NOP
    }
    
}
