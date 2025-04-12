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

class ProfileViewModel {
    var coordinator: MainCoordinator?
    let sections: [sections] = [.profile, .selection, .collection]
    let selections: [ProfileSelections] = [.photos, .likes, .collections]
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error
        case idle
    }
    
    var index = 0
    var userData: UserModel?
    var completion: ((String) -> Void)?
    var success: (() -> Void)?
    var stateUpdate: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdate?(state)
        }
    }

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
                    LayoutClass.createHorizontalDoubleCell()
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
            switch self.selections[index] {
            case .photos:
                10
            case .likes:
                5
            case .collections:
                5
            }
        }
    }
    
    func getUserData() {
        state = .loading
        FirestoreManager.shared.getUserData { [weak self] data, error in
            guard let self else {return}
            
            if let error = error {
                completion?(error)
            } else {
                userData = data
                UserDefaults.standard.set(data?.accessKey, forKey: "key")
                state = .success
                state = .loaded
            }
        }
    }
}
