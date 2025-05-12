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
    
    var collectoinsId: String
    var data: [UsersCollections]?
    var userCollections: UsersCollections?
    
    init(collectoinsId: String) {
        self.collectoinsId = collectoinsId
    }
    
    //MARK: - Collection Layout
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            UserCollectionLayout.collectionPhotos()
        }
    }
    
    func deleteCollection() {
        FirestoreManager.shared.deleteDocument(collectionType: .collectionOfPhotosCollection, docName: userCollections?.collectionName ?? "") { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
            }
        }
    }
    
    func getCollection() {
        state = .loading
        FirestoreManager.shared.getADocument(collectionType: .collectionOfPhotosCollection, id: collectoinsId, model: UsersCollections.self, completion: { data, error in
            if let error = error {
                self.state = .error(error)
                self.state = .loaded
            } else {
                self.data = data ?? []
                self.userCollections = self.data?.first
                self.state = .success
                self.state = .loaded
            }
        })
    }
}
