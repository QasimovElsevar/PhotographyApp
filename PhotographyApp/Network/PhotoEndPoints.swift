//
//  PhotoEndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

enum  PhotosEndPoint {
    case listOfPhotos(Int)
    case downloadTrack(Int)
    
    var path: String {
        switch self {
        case .listOfPhotos(let page):
            NetworkManager.shared.configureUrl(endPoint: "photos?page=\(page)")
        case .downloadTrack(let id):
            NetworkManager.shared.configureUrl(endPoint: "photos/:\(id)/download")
        }
    }
}

enum  PhotoActionsEndPoints {
    case upload(Int)
    case like(Int)
    case unlike(Int)
    
    var path: String {
        switch self {
        case .upload(let id):
            NetworkManager.shared.configureUrl(endPoint: "photos/:\(id)")
        case .like(let id):
            NetworkManager.shared.configureUrl(endPoint: "/photos/:\(id)/like")
        case .unlike(let id):
            NetworkManager.shared.configureUrl(endPoint: "/photos/:\(id)/like")
        }
    }
}
