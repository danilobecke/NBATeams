//
//  Standings.swift
//  NBA Teams
//
//  Created by Danilo Becke on 21/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import Foundation

struct Standings: Codable {
    let league: Leage

    struct Leage: Codable {
        let standard: LeagueData
    }
}

struct LeagueData: Codable {
    let seasonYear: Int
    let conference: Conference

    struct Conference: Codable {
        let east: [TeamStandings]
        let west: [TeamStandings]
    }
}

struct TeamStandings: Codable {
    let teamId: String
    let win: String
    let loss: String
    let winPercentage: String
    let confRank: String
    let lastTenWin: String
    let lastTenLoss: String
    
    enum CodingKeys: String, CodingKey {
        case teamId, win, loss, confRank, lastTenWin, lastTenLoss
        case winPercentage = "winPctV2"
    }
}
