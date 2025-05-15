//
//  AddToCollectionManager.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import Foundation

final class NewPhotoToCollectionManager: NewPhotoToCollectionUseCase {
    
    func updateNumberOfPhotosInCollection(collectionName: String, parameter: [String : Any], completion: @escaping (String?) -> Void) {
        FirestoreManager.shared.updateData(docName: collectionName, collectionType: .collectionOfPhotosCollection, updatedField: "numberOfPhotos", parameters: parameter, completion: completion)
    }
    
    
    func getCollections(completion: @escaping ([UsersCollections]?, String?) -> Void) {
        FirestoreManager.shared.getData(collectionType: .collectionOfPhotosCollection, model: UsersCollections.self, completion: completion)
    }
    
    func addPhotoToCollection(collectionName: String, parameter: [String: Any], completion: @escaping (String?) -> Void) {
        FirestoreManager.shared.updateData(docName: collectionName, collectionType: .collectionOfPhotosCollection, updatedField: "photos", parameters: parameter, completion: completion)
    }
    
    func deletePhotoFromCollection(collectionName: String, photoId: String, completion: @escaping (String?) -> Void) {
        FirestoreManager.shared.deletePhotoFromCollection(docName: collectionName, field: "photos", photoID: photoId, completion: completion)
    }
}
