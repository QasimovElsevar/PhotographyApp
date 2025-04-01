//
//  PostForAccesKey.swift
//  PhotographyApp
//
//  Created by Elsever on 01.04.25.
//

import Foundation

struct PostForAccesKey: Codable {
    let accessToken: String?
    let tokenType: String?
    let scope: String?
    let createdAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
        case createdAt = "created_at"
    }
}
