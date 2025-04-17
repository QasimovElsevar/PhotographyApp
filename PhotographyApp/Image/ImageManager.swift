//
//  ImageManager.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import Foundation

class ImageManager: ImageUserCase {
    
    func likePhoto(id: String) async throws -> Photos {
        let path = PhotoActionsEndPoints.like(id).path
        return try await NetworkManager.shared.request(endPoint: path, model: Photos.self)
    }
    
    func getPhoto(id: String) async throws -> PhotoDetails {
        let path = PhotosEndPoint.photo(id).path
        return try await NetworkManager.shared.request(endPoint: path, model: PhotoDetails.self)
    }
    
    func getRelatedPhotos(query: String) async throws -> Search {
        let path = SearchEndPoints.searchPhoto(query, 1).path
        return try await NetworkManager.shared.request(endPoint: path, model: Search.self)
    }
}
