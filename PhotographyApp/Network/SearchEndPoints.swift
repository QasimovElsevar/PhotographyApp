//
//  SearchEndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

enum SearchEndPoints {
    case searchPhoto(String)
    case searchCollection(String)
    case searchUser(String)
    
    var path: String {
        switch self {
        case .searchPhoto(let query):
            NetworkManager.shared.configureUrl(endPoint: "search/photos?query=\(query)")
        case .searchCollection(let query):
            NetworkManager.shared.configureUrl(endPoint: "search/collections?query=\(query)")
        case .searchUser(let query):
            NetworkManager.shared.configureUrl(endPoint: "search/users?query=\(query)")
        }
    }
}
