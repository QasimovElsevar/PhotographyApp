//
//  AddToCollectionManager.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import Foundation

class AddToCollectionManager: AddToCollectionUseCase {
    
    func deletePhotoFromCollection(id: String, collectionId: String) async throws -> CollectionsPhoto {
        let path = CollectionsEndPoints.addToCollection(collectionId, id).path
        return try await NetworkManager.shared.request(endPoint: path, model: CollectionsPhoto.self, method: .delete)
    }
    
    func addPhotoToCollection(id: String, collectionId: String) async throws -> CollectionsPhoto {
        let path = CollectionsEndPoints.addToCollection(collectionId, id).path
        return try await NetworkManager.shared.request(endPoint: path, model: CollectionsPhoto.self, method: .post)
    }
    
    func getCollections() async throws -> [Collections] {
        let path = CollectionsEndPoints.userCollections("elfuciy").path
        return try await NetworkManager.shared.request(endPoint: path, model: [Collections].self)
    }
}
