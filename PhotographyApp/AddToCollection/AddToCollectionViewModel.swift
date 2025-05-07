//
//  AddToCollectionViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import Foundation
import Firebase

class AddToCollectionViewModel {
     
    let manager = AddToCollectionManager()
//    var userCollection: UsersCollections
    var photo: UsersPhotos?
    var collections: [UsersCollections] = []
    var photoId: String
    
    init(photoId: String, photo: UsersPhotos? = nil) {
        self.photoId = photoId
        self.photo = photo
    }
    
    //MARK: - States
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
        case idle
    }

    var stateUpdate: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdate?(state)
        }
    }
    
    
    func createCollection() {
        
        let photos = ["url": photo?.url ?? "",
                      "author": photo?.author ?? "",
                      "blurHash" : photo?.blurHash ?? ""]
        
        let data: [String: Any] = [
            "collectionName": "aaaa",
            "createdAt": photo?.createdAt ?? Date(),
            "photos": FieldValue.arrayUnion([photos]),
            "numberOfPhotos": 0
        ]
        
        FirestoreManager.shared.saveData(collectionType: .collectionOfPhotosCollection, docName: "aaaa", parameters: data) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        }
    }
    
    func getCollections() {
        FirestoreManager.shared.getData(collectionType: .collectionOfPhotosCollection, model: UsersCollections.self) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.collections = data ?? []
                self.state = .success
            }
        }
    }
    
    func addPhotoToCollection(collectionName: String) {
        
        let photos: [String : Any] = ["photoUrl": photo?.url ?? "",
                                      "authorName": photo?.author ?? ""]
        
        FirestoreManager.shared.addPhotoToCollection(docName: collectionName, updatedField: "photos", parameters: photos, completion: { error in
            if let error = error {
                print("Error adding photo to collection: \(error)")
            } else {
                print("Photo added to collection successfully!")
            }
        })
    }
}
