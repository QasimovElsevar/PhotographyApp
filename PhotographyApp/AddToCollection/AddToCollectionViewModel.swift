//
//  AddToCollectionViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import Foundation

class AddToCollectionViewModel {
     
    let manager = AddToCollectionManager()
    var collections: [Collections] = []
    var photoId: String
//    var usersCollections
    
    init(photoId: String) {
        self.photoId = photoId
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
    
    func getCollections() async {
        do {
            let collections = try await manager.getCollections()
            
            Task {
                self.collections = collections
                state = .success
            }
        } catch {
            state = .error(error.localizedDescription)
            print("error")
        }
    }
    
    func addToCollection(collectionId: String) async {
        do {
            let _ = try await manager.addPhotoToCollection(id: photoId, collectionId: collectionId)
            
            Task {
                state = .success
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func deleteFromCollection(collectionId: String) async {
        do {
            let _ = try await manager.deletePhotoFromCollection(id: photoId, collectionId: collectionId)
            
            Task {
                state = .success
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
