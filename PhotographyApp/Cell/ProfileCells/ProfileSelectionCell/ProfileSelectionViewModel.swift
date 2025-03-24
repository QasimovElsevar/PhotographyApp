//
//  ProfileSelectionModelView.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import Foundation

enum Selections {
    case photos
    case likes
    case collections
}

class ProfileSelectionViewModel {
    
    let selections: [Selections] = [.photos, .likes, .collections]
}
