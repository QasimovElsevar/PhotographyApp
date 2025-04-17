//
//  PhotoEndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

enum  PhotosEndPoint {
    case photo(String)
    case listOfPhotos(Int)
    case downloadTrack(String)
    
    var path: String {
        switch self {
        case .photo(let id):
            NetworkManager.shared.configureUrl(endPoint: "photos/\(id)")
        case .listOfPhotos(let page):
            NetworkManager.shared.configureUrl(endPoint: "photos?page=\(page)")
        case .downloadTrack(let id):
            NetworkManager.shared.configureUrl(endPoint: "photos/:\(id)/download")
        }
    }
}

enum  PhotoActionsEndPoints {
    case upload(String)
    case like(String)
    case unlike(String)
    
    var path: String {
        switch self {
        case .upload(let id):
            NetworkManager.shared.configureUrl(endPoint: "photos/\(id)")
        case .like(let id):
            NetworkManager.shared.configureUrl(endPoint: "photos/\(id)/like")
        case .unlike(let id):
            NetworkManager.shared.configureUrl(endPoint: "photos/\(id)/like")
        }
    }
}
