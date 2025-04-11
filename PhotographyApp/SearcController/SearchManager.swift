//
//  SearchManager.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

class SearchManager: SearchUserCase {
    
    let manager = NetworkManager()
    
    func getList(page: Int) async throws -> [Photos] {
        let path = PhotosEndPoint.listOfPhotos(page).path
        return try await manager.request(endPoint: path, model: [Photos].self)
    }
}
