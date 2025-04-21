//
//  EndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import Foundation

enum TopicsEndPoint {
    case topic
    case topicPhotos(String)
    
    var path: String {
        switch self {
        case .topic:
            NetworkManager.shared.configureUrl(endPoint: "topics")
        case .topicPhotos(let idOrSlug):
            NetworkManager.shared.configureUrl(endPoint: "/topics/\(idOrSlug)/photos")
        }
    }
}


