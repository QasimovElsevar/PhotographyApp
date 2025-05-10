//
//  UserCollectionViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 19.04.25.
//

import UIKit

final class UserCollectionViewModel {
    
    //MARK: - State
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
    
    let manager = UserCollectionManager()
    
    var photos: [UsersPhotos]?
    var title: String
    
    init(title: String, photos: [UsersPhotos]? = nil) {
        self.title = title
        self.photos = photos
    }
    
    //MARK: - Collection Layout
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            UserCollectionLayout.collectionPhotos()
        }
    }
    
    func deleteCollection() {
        FirestoreManager.shared.deleteDocument(collectionType: .collectionOfPhotosCollection, docName: title) { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        }
    }
}
