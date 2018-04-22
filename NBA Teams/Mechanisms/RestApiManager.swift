//
//  RestApiManager.swift
//  NBA Teams
//
//  Created by Danilo Becke on 21/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import Foundation

enum ServiceResponse<T> {
    case error
    case success(result: T)
}

class RestApiManager {
    
    private static let decoder = JSONDecoder()
    
    static func makeHTTPGetRequest<T>(path: URL,
                                      onCompletion: @escaping (ServiceResponse<T>) -> Void)
                                      where T: Codable {
                                        
        if let response = CacheManager.getOnCache(path),
            let codableRespose = try? decoder.decode(T.self, from: response) {
                onCompletion(ServiceResponse.success(result: codableRespose))
                return
        }
                                        
        var request = URLRequest(url: path, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 20)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do {
                    let codableResponse = try decoder.decode(T.self, from: jsonData)
                    CacheManager.writeOnCache(jsonData, path: path)
                    onCompletion(ServiceResponse.success(result: codableResponse))
                } catch {
                    onCompletion(ServiceResponse.error)
                }
            } else {
                onCompletion(ServiceResponse.error)
            }
        }
        task.resume()
    }
}
