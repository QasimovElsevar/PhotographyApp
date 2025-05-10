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
    var userPhotos: [UsersPhotos] = []
    var userLiked: [UsersPhotos] = []
    var userCollections: [UsersCollections] = []
    var userData: UserModel?
    
    //MARK: - States
    
    enum ViewState {
        case loading
        case loaded
        case signedOut
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
                    if self.userPhotos.isEmpty {
                        ProfileCellLayout.wholeScreen()
                    } else {
                        ProfileCellLayout.createHorizontalDoubleCell()
                    }
                case .likes:
                    if self.userLiked.isEmpty {
                        ProfileCellLayout.wholeScreen()
                    } else {
                        ProfileCellLayout.likedPhotos()
                    }
                case .collections:
                    if self.userCollections.isEmpty {
                        ProfileCellLayout.wholeScreen()
                    } else {
                        ProfileCellLayout.profileCollection()
                    }
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
                if self.userPhotos.isEmpty {
                    1
                } else {
                    userPhotos.count
                }
            case .likes:
                if self.userLiked.isEmpty {
                    1
                } else {
                    userLiked.count
                }
            case .collections:
                if self.userCollections.isEmpty {
                    1
                } else {
                    userCollections.count
                }
            }
        }
    }
    
    //MARK: - Data
    
    func getUserData() async {
        switch selections[self.index] {
        case .photos:
            getUserPhotos()
        case .likes:
            getUsersLikedPhotos()
        case .collections:
            getCollections()
        }
    }
    
    func getUsersLikedPhotos() {
        FirestoreManager.shared.getData(collectionType: .likedPhotoCollection, model: UsersPhotos.self) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.userLiked = data ?? []
                self.state = .success
            }
        }
    }
    
    func getCollections() {
        FirestoreManager.shared.getData(collectionType: .collectionOfPhotosCollection, model: UsersCollections.self) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.userCollections = data ?? []
                self.state = .success
            }
        }
    }
    
    func getUserPhotos() {
        FirestoreManager.shared.getData(collectionType: .userPhotos, model: UsersPhotos.self) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .success
                self.userPhotos = data ?? []
            }
        }
    }
    
    func getUser() {
        FirestoreManager.shared.getData(collectionType: .userDataCollection, model: UserModel.self, completion: { [weak self] data, error in
            guard let self else {return}
            
            if let error = error {
                state = .error(error)
                state = .loaded
            } else {
                userData = data?.first
                UserDefaults.standard.set(userData?.accessKey, forKey: "key")
                state = .success
                state = .loaded
            }
        })
    }
    
    func signOut() {
        FireBaseManager.shared.signOut { error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.state = .signedOut
            }
        }
    }
}
