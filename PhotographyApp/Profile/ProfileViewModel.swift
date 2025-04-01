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
    let sections: [sections] = [.profile, .selection, .collection]
    let selections: [ProfileSelections] = [.photos, .likes, .collections]
    
    var index = 0
    var userData: UserModel?
    var completion: ((String) -> Void)?
    var success: (() -> Void)?

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
        FirestoreManager.shared.getUserData { [weak self] data, error in
            if let error = error {
                self?.completion?(error)
            } else {
                self?.userData = data
                UserDefaults.standard.set(data?.accessKey, forKey: "key")
                self?.success?()
            }
        }
    }
}
