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

class ProfileViewModel {
    let sections: [sections] = [.profile, .selection, .collection]
    
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .profile:
                ProfileCellLayout.profileCell()
            case .selection:
                ProfileCellLayout.selectionCell()
            case .collection:
                ProfileCellLayout.profileCollection()
            }
        }
    }
    
    func numberOfCells(index: Int) -> Int{
        switch sections[index] {
        case .profile, .selection, .collection:
            1
        }
    }
}
