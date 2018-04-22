//
//  CacheManager.swift
//  NBA Teams
//
//  Created by Danilo Becke on 22/04/2018.
//  Copyright © 2018 Danilo Becke. All rights reserved.
//

import Foundation

class CacheManager {
    
    // expiration time: 30 min
    private static let expirationTime: TimeInterval = 1800
    
    // MARK: - API
    static func getOnCache(_ path: URL) -> Data? {
        do {
            let cache = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask,
                                                         appropriateFor: nil, create: false)
            let url = cache.appendingPathComponent(path.lastPathComponent, isDirectory: false)
            
            guard FileManager.default.fileExists(atPath: url.path) else {
                return nil
            }
            
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            
            guard let creationDate = attributes[.creationDate] as? Date,
                Date().timeIntervalSince(creationDate) < expirationTime,
                let data = FileManager.default.contents(atPath: url.path) else {
                    try removeFile(url)
                    return nil
            }
            
            return data
        } catch {
            return nil
        }
    }
    
    @discardableResult
    static func writeOnCache(_ response: Data, path: URL) -> Bool {
        do {
            let cache = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let url = cache.appendingPathComponent(path.lastPathComponent, isDirectory: false)
            if FileManager.default.fileExists(atPath: url.path) {
                try removeFile(url)
            }
            FileManager.default.createFile(atPath: url.path, contents: response, attributes: nil)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - Internal work
    private static func removeFile(_ path: URL) throws {
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            throw error
        }
    }
}
