//
//  CollectionsEndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 19.04.25.
//

import Foundation

enum CollectionsEndPoints {
    case userCollections(String)
    case searchCollection(String)
    case collectionPhotos(String)
    case addToCollection(String, String)
    
    var path: String {
        switch self {
        case .userCollections(let username):
            NetworkManager.shared.configureUrl(endPoint: "/users/\(username)/collections")
        case .searchCollection(let query):
            NetworkManager.shared.configureUrl(endPoint: "search/collections?query=\(query)")
        case .collectionPhotos(let id):
            NetworkManager.shared.configureUrl(endPoint: "/collections/\(id)/photos")
        case .addToCollection(let collectionId, let id):
            NetworkManager.shared.configureUrl(endPoint: "/collections/\(collectionId)/add?photo_id\(id)")
        }
    }
}
