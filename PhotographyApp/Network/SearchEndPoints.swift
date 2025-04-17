//
//  SearchEndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

enum SearchEndPoints {
    case searchPhoto(String, Int)
    case searchCollection(String)
    case searchUser(String)
    
    var path: String {
        switch self {
        case .searchPhoto(let query, let page):
            NetworkManager.shared.configureUrl(endPoint: "search/photos?query=\(query)&page=\(page)")
        case .searchCollection(let query):
            NetworkManager.shared.configureUrl(endPoint: "search/collections?query=\(query)")
        case .searchUser(let query):
            NetworkManager.shared.configureUrl(endPoint: "search/users?query=\(query)")
        }
    }
}
