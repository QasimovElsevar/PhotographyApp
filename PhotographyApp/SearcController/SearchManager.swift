//
//  SearchManager.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

final class SearchManager: SearchUserCase {
    
    let manager = NetworkManager()
    
    func getSearchResult(query: String, page: Int) async throws -> Search {
        let path = SearchEndPoints.searchPhoto(query, page).path
        return try await manager.request(endPoint: path, model: Search.self)
    }
}
