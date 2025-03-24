//
//  ProfileCollectionViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import Foundation
import UIKit

enum ProfileSelections {
    case photos
    case likes
    case collections
}

class ProfileCollectionViewModel {
    let selections: [ProfileSelections] = [.photos, .likes, .collections]
    
//    func createLayaout(tag: Int) -> UICollectionViewCompositionalLayout {
////        UICollectionViewCompositionalLayout { sectionNumber, environment in
////            switch self.selections[tag] {
////            case .photos:
////                
////            case .likes:
////                
////            case .collections:
////            }
////        }
//    }
}
