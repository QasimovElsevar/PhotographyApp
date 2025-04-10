//
//  Search.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

// MARK: - Welcome
struct Search: Codable {
    let total, totalPages: Int?
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id: String?
    let createdAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let likes: Int?
    let likedByUser: Bool?
    let description: String?
    let user: User?
    let currentUserCollections: [JSONAny]?
    let urls: Urls?
    let links: ResultLinks?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height, color
        case blurHash = "blur_hash"
        case likes
        case likedByUser = "liked_by_user"
        case description, user
        case currentUserCollections = "current_user_collections"
        case urls, links
    }
}

// MARK: - ResultLinks
struct ResultLinks: Codable {
    let linksSelf: String?
    let html, download: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
    }
}



