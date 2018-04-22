//
//  AllTeams.swift
//  NBA Teams
//
//  Created by Danilo Becke on 21/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import UIKit

fileprivate struct DummyCodable: Codable {}

struct AllTeams: Codable {
    
    let teams: TeamsData
    
    struct TeamsData: Codable {
        let config: [Team]
        
        init(from decoder: Decoder) throws {
            var teams = [Team]()
            let container = try decoder.container(keyedBy: CodingKeys.self)
            var nested = try container.nestedUnkeyedContainer(forKey: .config)
            while nested.isAtEnd == false {
                if let team = try? nested.decode(Team.self) {
                    teams.append(team)
                } else {
                    // currentIndex is not incremented unless a decode succeeds
                    // https://bugs.swift.org/browse/SR-5953
                    _ = try? nested.decode(DummyCodable.self)
                }
            }
            self.config = teams
        }
    }
}

struct Team: Codable {
    let teamId: String
    let tricode: String
    let name: String
    
    private let _primaryColor: String
    var primaryColor: UIColor? {
        return UIColor.fromHexString(_primaryColor)
    }
    
    let app: AppInfo
    let web: WebInfo
    
    enum CodingKeys: String, CodingKey {
        case teamId, tricode, app, web
        case _primaryColor = "primaryColor"
        case name = "ttsName"
    }
    
    struct AppInfo: Codable {
        let ios: String
    }
    
    struct WebInfo:Codable {
        let homepage: String
    }
}
