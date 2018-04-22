//
//  AllTeamsBO.swift
//  NBA Teams
//
//  Created by Danilo Becke on 22/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import Foundation

protocol AllTeamsDelegate {
    func didSucceed(withTeams: AllTeams)
    func didFail()
}

class AllTeamsBO {
    private let delegate: AllTeamsDelegate
    
    init(withDelegate delegate: AllTeamsDelegate) {
        self.delegate = delegate
    }
    
    func getTeams() {
        guard let url = Route.teams(year: 2017).path() else {
            delegate.didFail()
            return
        }
        
        RestApiManager.makeHTTPGetRequest(path: url) { (response: ServiceResponse<AllTeams>) in
            
            DispatchQueue.main.async {
                switch response {
                case .error:
                    self.delegate.didFail()
                case .success(let allTeams):
                    self.delegate.didSucceed(withTeams: allTeams)
                }
            }
        }
    }
}
