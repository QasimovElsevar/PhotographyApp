//
//  ImageManager.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import Foundation

final class ImageManager: ImageUserCase {
    
    func deletePhoto(id: String, completion: @escaping (String?) -> Void) {
        FirestoreManager.shared.deleteDocument(collectionType: .userPhotos, docName: "\(id) images", completion: completion)
    }
    
    func getAPhoto(id: String, completion: @escaping ([UsersPhotos]?, String?) -> Void) {
        FirestoreManager.shared.getADocument(collectionType: .userPhotos, id: id, model: UsersPhotos.self, completion: completion)
    }
    
    func unlikePhoto(id: String, completion: @escaping (String?) -> Void) {
        FirestoreManager.shared.deleteDocument(collectionType: .likedPhotoCollection, docName: id, completion: completion)
    }
    
    func likePhoto(id: String, parameter: [String: Any], completion: @escaping (String?) -> Void) {
        FirestoreManager.shared.saveData(collectionType: .likedPhotoCollection, docName: id, parameters: parameter, completion: completion)
    }
    
    func checkLike(completion: @escaping ([UsersPhotos]?, String?) -> Void) {
        FirestoreManager.shared.getData(collectionType: .likedPhotoCollection, model: UsersPhotos.self, completion: completion)
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
