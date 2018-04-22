//
//  StandingsBO.swift
//  NBA Teams
//
//  Created by Danilo Becke on 21/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import Foundation

protocol StandingsDelegate {
    func didSucceed(withStandings: Standings)
    func didFail()
}

class StandingsBO {
    private let delegate: StandingsDelegate
    
    init(withDelegate delegate: StandingsDelegate) {
        self.delegate = delegate
    }
    
    func getStandings() {
        guard let url = Route.standings.path() else {
            delegate.didFail()
            return
        }
        
        RestApiManager.makeHTTPGetRequest(path: url) { (response: ServiceResponse<Standings>) in
            
            DispatchQueue.main.async {
                switch response {
                case .error:
                    self.delegate.didFail()
                case .success(let standings):
                    self.delegate.didSucceed(withStandings: standings)
                }
            }
        }
    }
}
