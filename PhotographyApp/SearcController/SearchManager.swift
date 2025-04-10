//
//  SearchManager.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

class SearchManager: SearchUserCase {
    
    let manager = NetworkManager()
    
    func search(query: String) async throws -> [Photos] {
        let path = SearchEndPoints.searchPhoto(query).path
        return try await manager.request(endPoint: path, model: [Photos].self)
    }
}
