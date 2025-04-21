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
    
    var photos: [Photos] = []
    var title: String
    var id: String
    
    init(id: String, title: String) {
        self.title = title
        self.id = id
    }
    
    //MARK: - Collection Layout
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            UserCollectionLayout.collectionPhotos()
        }
    }
    
    func getCollection() async {
        do {
            let data = try await manager.fetchUserCollection(id: id)
            Task {
                photos = data
                state = .success
            }
        } catch { 
            state = .error(error.localizedDescription)
        }
    }
}
