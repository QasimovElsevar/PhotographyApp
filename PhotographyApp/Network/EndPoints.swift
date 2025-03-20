//
//  EndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import Foundation

enum TopicsEndPoint {
    case list
    
    var path: String {
        switch self {
        case .list:
//            NetworkManager.shared.configureUrl(endPoint: "topics")
            "https://api.unsplash.com/topics/?client_id=x8sJp7pb7aDawfONcfXXuwkjGhCJecnUvbR-vZBQtC4"
        }
    }
}
