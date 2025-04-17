//
//  UserEndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 17.04.25.
//

import Foundation

enum UserEndPoints {
    case userPhotos
    case userLikes
    case userCollections
    
    var path: String {
        switch self {
        case .userLikes:
            NetworkManager.shared.configureUrl(endPoint: "/users/elfuciy/likes")
        case .userPhotos:
            NetworkManager.shared.configureUrl(endPoint: "/users/elfuciy/photos")
        case .userCollections:
            NetworkManager.shared.configureUrl(endPoint: "/users/elfuciy/collections")
        }
    }
}
