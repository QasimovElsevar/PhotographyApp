//
//  Photos.swift
//  PhotographyApp
//
//  Created by Elsever on 01.04.25.
//

import Foundation

struct Photos: Codable {
    let id, slug: String?
    let alternativeSlugs: AlternativeSlugs?
    let createdAt, updatedAt: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description: String?
    let altDescription: String?
    let breadcrumbs: [JSONAny]?
    let urls: Urls?
    let links: PhotoLinks?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [JSONAny]?
    let sponsorship: JSONNull?
    let topicSubmissions: TopicSubmissions?
    let assetType: AssetTypeElement?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case alternativeSlugs = "alternative_slugs"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case breadcrumbs, urls, links, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
        case topicSubmissions = "topic_submissions"
        case assetType = "asset_type"
        case user
    }
}
