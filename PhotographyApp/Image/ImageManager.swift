//
//  ImageManager.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import Foundation

final class ImageManager: ImageUserCase {
    
    func addPhotoToCollection(id: String, collectionId: String) async throws -> CollectionsPhoto {
        let path = CollectionsEndPoints.addToCollection(collectionId, id).path
        return try await NetworkManager.shared.request(endPoint: path, model: CollectionsPhoto.self, method: .post)
    }
    
    
//    func removePhotoFromCollection(id: String, collectionId: String) async throws -> Photos {
//        print("hjk")
//    }
    
    
    func unlikePhoto(id: String) async throws -> Photos {
        let path = PhotoActionsEndPoints.like(id).path
        return try await NetworkManager.shared.request(endPoint: path, model: Photos.self, method: .delete)
    }
    
    func likePhoto(id: String) async throws -> Photos {
        let path = PhotoActionsEndPoints.like(id).path
        return try await NetworkManager.shared.request(endPoint: path, model: Photos.self, method: .post)
    }
    
    func getPhoto(id: String) async throws -> PhotoDetails {
        let path = PhotosEndPoint.photo(id).path
        return try await NetworkManager.shared.request(endPoint: path, model: PhotoDetails.self)
    }
    
    func getRelatedPhotos(query: String) async throws -> Search {
        let path = PhotosEndPoint.searchPhoto(query, 1).path
        return try await NetworkManager.shared.request(endPoint: path, model: Search.self)
    }
}
