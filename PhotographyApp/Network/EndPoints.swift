//
//  EndPoints.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import Foundation

enum TopicsEndPoint {
    case topic
    
    var path: String {
        switch self {
        case .topic:
            NetworkManager.shared.configureUrl(endPoint: "topics")
        }
    }
}


