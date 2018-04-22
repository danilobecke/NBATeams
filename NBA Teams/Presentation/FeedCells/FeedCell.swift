//
//  FeedCell.swift
//  NBA Teams
//
//  Created by Danilo Becke on 18/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

protocol FeedCell {
    var height: Float { get }
    func didSelect(tableView: UITableView)
}
