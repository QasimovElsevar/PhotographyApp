//
//  UserEndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 17.04.25.
//

import Foundation

enum UserEndPoints {
    case userPhotos(String)
    case userLikes(String)
    case userCollections(String)
    
    var path: String {
        switch self {
        case .userLikes(let username):
            NetworkManager.shared.configureUrl(endPoint: "/users/\(username)/likes")
        case .userPhotos(let username):
            NetworkManager.shared.configureUrl(endPoint: "/users/\(username)/photos")
        case .userCollections(let username):
            NetworkManager.shared.configureUrl(endPoint: "/users/\(username)/collections")
        }
    }
}
