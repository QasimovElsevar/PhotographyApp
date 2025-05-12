//
//  NewCollectionControllerViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 07.05.25.
//

import Foundation
import Firebase

final class NewCollectionControllerViewModel {
    
    var photo: UsersPhotos?
    var callBack: (() -> Void)?
    
    init(photo: UsersPhotos? = nil) {
        self.photo = photo
    }
    
    //MARK: - States
    
    enum ViewState {
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
    
    func createCollection(collectionName: String) {
        
        let photos = ["url": photo?.url ?? "",
                      "author": photo?.author ?? "",
                      "blurHash" : photo?.blurHash ?? "",
                      "id": photo?.id ?? ""]
        
        let data: [String: Any] = [
            "id": String(UUID().uuidString),
            "collectionName": collectionName,
            "createdAt": Date(),
            "photos": FieldValue.arrayUnion([photos]),
            "numberOfPhotos": 1
        ]
        
        FirestoreManager.shared.saveData(collectionType: .collectionOfPhotosCollection, docName: collectionName, parameters: data) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        }
    }
}
