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
    var userLiked: [LikedPhotos] = []
    var userCollections: [UsersCollections] = []
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
                        ProfileCellLayout.likedPhotos()
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
                userLiked.count
            case .collections:
                userCollections.count
            }
        }
    }
    
    //MARK: - Data
    
    func getUserData() async {
        switch selections[self.index] {
        case .photos:
            do {
                let data = try await manager.getPhotos()
                Task {
                    userPhotos = data
                    state = .success
                    state = .loaded
                }
            } catch {
                state = .error(error.localizedDescription)
            }
        case .likes:
            getUsersLikedPhotos()
        case .collections:
            getCollections()
        }
    }
    
    func makeRequest() async {
     
    }
    
    func getUsersLikedPhotos() {
        FirestoreManager.shared.getData(collectionType: .likedPhotoCollection, model: LikedPhotos.self) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.userLiked = data ?? []
                self.state = .success
            }
        }
    }
    
    func getCollections() {
        FirestoreManager.shared.getData(collectionType: .likedPhotoCollection, model: LikedPhotos.self) { data, error in
            if let error = error {
                self.state = .error(error)
            } else {
                self.userLiked = data ?? []
                self.state = .success
            }
        }
    }
    
    func getUser() {
        state = .loading
        FirestoreManager.shared.getData(collectionType: .userDataCollection, model: UserModel.self, completion: { [weak self] data, error in
            guard let self else {return}
            
            if let error = error {
                state = .error(error)
            } else {
                userData = data?.first
                UserDefaults.standard.set(userData?.accessKey, forKey: "key")
                state = .success
                state = .loaded
            }
        })
    }
}
