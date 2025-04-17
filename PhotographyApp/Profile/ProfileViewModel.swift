//
//  ProfileViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import Foundation
import UIKit
enum sections {
    case profile
    case selection
    case collection
}

enum ProfileSelections {
    case photos
    case likes
    case collections
}

final class ProfileViewModel {
    
    //MARK: - Properies
    
    var coordinator: MainCoordinator?
    let manager = ProfileManager()
    var index = 0
    var userPhotos: [Photos] = []
    var userLiked: [Photos] = []
    var userCollections: [Collections] = []
    var userData: UserModel?
    
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
    
    //MARK: - Collecrtion Layout
    
    let sections: [sections] = [.profile, .selection, .collection]
    let selections: [ProfileSelections] = [.photos, .likes, .collections]
    
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .profile:
                ProfileCellLayout.profileCell()
            case .selection:
                ProfileCellLayout.selectionCell()
            case .collection:
                switch self.selections[self.index] {
                case .photos:
                    ProfileCellLayout.createHorizontalDoubleCell()
                case .likes:
                    ProfileCellLayout.profileCollection()
                case .collections:
                    ProfileCellLayout.profileCollection()
                }
                
            }
        }
    }
    
    func numberOfCells(index: Int) -> Int{
        switch sections[index] {
        case .profile, .selection:
            1
        case .collection:
            switch self.selections[self.index] {
            case .photos:
                userPhotos.count
            case .likes:
                userPhotos.count
            case .collections:
                userPhotos.count
            }
        }
    }
    
    //MARK: - Data
    
    func getUserData() async {
        do {
            switch selections[self.index] {
            case .photos:
                let data = try await manager.getPhotos()
                Task {
                    userPhotos = data
                    state = .success
                }
            case .likes:
                let data = try await manager.getLikes()
                Task {
                    userPhotos = data
                    state = .success
                }
            case .collections:
                let data = try await manager.getCollections()
                Task {
                    userPhotos = data
                    state = .success
                }
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
        
    }
    
    func makeRequest() async {
     
    }
    
    func getUser() {
        state = .loading
        FirestoreManager.shared.getUserData { [weak self] data, error in
            guard let self else {return}
            
            if let error = error {
                state = .error(error)
            } else {
                userData = data
                UserDefaults.standard.set(data?.accessKey, forKey: "key")
                state = .success
                state = .loaded
            }
        }
    }
}
