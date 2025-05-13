//
//  FeedManager.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import Foundation

final class FeedManager {
    
    let manager = NetworkManager()
    
    func getList(page: Int) async throws -> [Photos] {
        let path = PhotosEndPoint.listOfPhotos(page).path
        return try await manager.request(endPoint: path, model: [Photos].self)
    }
}
