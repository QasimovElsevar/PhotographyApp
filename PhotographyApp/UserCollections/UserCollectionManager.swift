//
//  UserCollectionManager.swift
//  PhotographyApp
//
//  Created by Elsever on 21.04.25.
//

import Foundation

final class UserCollectionManager: UserCollectionUserCase {
   
    let manager = NetworkManager()
    
    func getUsersCollection(id: String, completion: @escaping ([UsersCollections]?, String?) -> Void) {
        FirestoreManager.shared.getADocument(collectionType: .collectionOfPhotosCollection, id: id, model: UsersCollections.self, completion: completion)
    }
    
    func deleteCollection(collectionsName: String, completion: @escaping (String?) -> Void) {
        FirestoreManager.shared.deleteDocument(collectionType: .collectionOfPhotosCollection, docName: collectionsName, completion: completion)
    }
}
