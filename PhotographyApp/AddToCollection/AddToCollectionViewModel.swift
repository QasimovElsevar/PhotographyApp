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
    var collections: [Collections] = []
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
        
        let photos = ["photoUrl": photo?.url ?? "",
                      "authorName": photo?.author ?? ""]
        
        let data: [String: Any] = [
            "collectionName": "aaaa",
            "createdAt": photo?.createdAt ?? Date(),
            "photos": FieldValue.arrayUnion([photos])
        ]
        
        FirestoreManager.shared.saveData(collectionType: .collectionOfPhotosCollection, docName: photo?.id ?? "", parameters: data) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        }
    }
    
}
