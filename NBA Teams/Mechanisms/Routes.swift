//
//  Routes.swift
//  NBA Teams
//
//  Created by Danilo Becke on 21/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import Foundation

enum Route {
    private static let base: String = "http://data.nba.net/prod/"
    
    case teams(year: Int)
    case standings
    
    func path() -> URL? {
        let path: String
        switch self {
        case .standings:
            path = Route.base + "v1/current/standings_conference.json"
        case .teams(let year):
            path = Route.base + "\(year)/teams_config.json"
        }
        return URL(string: path)
    }
}
