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
    var photo: UsersPhotos?
    var isAdded: Bool = false
    var collections: [UsersCollections] = []
    var photoId: String
    var indexOfCollection: Int = 0
    
    init(photoId: String, photo: UsersPhotos? = nil) {
        self.photoId = photoId
        self.photo = photo
    }
    
    //MARK: - States
    
    enum ViewState {
        case added
        case deleted
        case impossibleToAdd
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
    
    func checkCollections(index: Int) {
        if !collections[index].photos.contains(where: {$0.id == self.photoId}) {
            self.isAdded = false
        } else {
            self.isAdded = true
        }
    }
    
    func addPhotoToCollection(collectionName: String) {
        
        let photos: [String : Any] = ["url": photo?.url ?? "",
                                      "blurHash": photo?.blurHash ?? "",
                                      "author": photo?.author ?? "",
                                      "id": photoId]
        FirestoreManager.shared.updateData(docName: collectionName, updatedField: "photos", parameters: photos, completion: { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .added
            }
        })
    }
    
    func updateNumberOfPhotos(collectionName: String, number: Int) {
        
        let numberOfPhotos: [String : Any] = ["numberOfPhotos": number]
        
        FirestoreManager.shared.updateData(docName: collectionName, updatedField: "numberOfPhotos", parameters: numberOfPhotos, completion: { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        })
    }
    
    func deleteFromCollection(collectionName: String) {
        let photos: [String : Any] = ["url": photo?.url ?? "",
                                      "blurHash": photo?.blurHash ?? "",
                                      "author": photo?.author ?? "",
                                      "id": photoId]
        
        FirestoreManager.shared.updateData(docName: collectionName, updatedField: "photos", parameters: photos, deleteField: true, completion: { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .deleted
            }
        })
    }
    
}
