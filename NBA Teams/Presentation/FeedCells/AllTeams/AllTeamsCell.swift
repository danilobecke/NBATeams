//
//  AllTeamsCell.swift
//  NBA Teams
//
//  Created by Danilo Becke on 22/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit
import SafariServices

class AllTeamsCell: UITableViewCell, FeedCell {

    // MARK: - FeedCell
    var height: CGFloat {
        if expanded {
            return 88
        } else {
            return 44
        }
    }
    
    func didSelect(tableView: UITableView) {
        self.expanded.toggle()
        tableView.reloadData()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var appStore: UIImageView?
    @IBOutlet weak var homepage: UIImageView?
    @IBOutlet weak var tShirtIcon: UIImageView?
    @IBOutlet var expandedConstraints: [NSLayoutConstraint]?
    @IBOutlet var compressedConstraints: [NSLayoutConstraint]?
    @IBOutlet var tricode: UILabel?
    
    // MARK: - Reactive vars
    var team: Team? {
        didSet {
            updateInterface()
        }
    }
    
    var expanded: Bool = false {
        didSet {
            updateInterface()
        }
    }
    
    // MARK: - Lifecycle
    init(withTeam team: Team) {
        self.team = team
        super.init(style: .default, reuseIdentifier: "team")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        let tapAppStoreGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectAppStore))
        self.appStore?.addGestureRecognizer(tapAppStoreGesture)
        let tapHomepageGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectHomepage))
        self.homepage?.addGestureRecognizer(tapHomepageGesture)
    }
    
    // MARK: - Internal work
    private func updateInterface() {
        self.name?.text = team?.name
        self.tricode?.text = " - \(team?.tricode ?? "")"
        
        self.backgroundColor = expanded ? UIColor.white : UIColor.clear
        
        let font = expanded ? UIFont.boldSystemFont(ofSize: 20) : UIFont.systemFont(ofSize: 17)
        self.name?.font = font
        self.tricode?.font = font
        
        self.tricode?.isHidden = !expanded
        self.appStore?.isHidden = !expanded
        self.homepage?.isHidden = !expanded
        self.tShirtIcon?.isHidden = !expanded
        self.tShirtIcon?.tintColor = team?.primaryColor
        
        for constraint in expandedConstraints ?? [] {
            constraint.priority = expanded ? .defaultHigh : .defaultLow
        }
        for constraint in compressedConstraints ?? [] {
            constraint.priority = expanded ? .defaultLow : .defaultHigh
        }
    }
    
    // MARK: - IBActions
    @objc private func didSelectAppStore() {
        guard let rawUrl = team?.app.ios, let url = URL(string: rawUrl) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC)
    }
    
    @objc private func didSelectHomepage() {
        guard let rawUrl = team?.web.homepage, let url = URL(string: rawUrl) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC)
    }
}
