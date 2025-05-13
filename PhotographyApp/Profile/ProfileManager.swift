//
//  ProfileManager.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import Foundation

final class ProfileManager: ProfileUseCase {
    
    func getUser(completion: @escaping ([UserModel]?, String?) -> Void) {
        FirestoreManager.shared.getData(collectionType: .userDataCollection, model: UserModel.self, completion: completion)
    }
    
    func getUsersPhotos(completion: @escaping ([UsersPhotos]?, String?) -> Void) {
        FirestoreManager.shared.getData(collectionType: .userPhotos, model: UsersPhotos.self, completion: completion)
    }
    
    func getUsersLikedPhotos(completion: @escaping ([UsersPhotos]?, String?) -> Void) {
        FirestoreManager.shared.getData(collectionType: .likedPhotoCollection, model: UsersPhotos.self, completion: completion)
    }
    
    func getUsersCollections(completion: @escaping ([UsersCollections]?, String?) -> Void) {
        FirestoreManager.shared.getData(collectionType: .collectionOfPhotosCollection, model: UsersCollections.self, completion: completion)
    }
//
//    func getPhotos() async throws -> [Photos] {
//        let path = UserEndPoints.userPhotos("elfuciy").path
//        return try await manager.request(endPoint: path, model: [Photos].self)
//    }
//    
//    func getLikes() async throws -> [Photos] {
//        let path = UserEndPoints.userLikes("elfuciy").path
//        return try await manager.request(endPoint: path, model: [Photos].self)
//    }
//    
//    func getCollections() async throws -> [Collections] {
//        let path = CollectionsEndPoints.userCollections("elfuciy").path
//        return try await manager.request(endPoint: path, model: [Collections].self)
//    }
}
