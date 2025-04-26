//
//  CollectionsPhoto.swift
//  PhotographyApp
//
//  Created by Elsever on 21.04.25.
//

import Foundation

struct CollectionsPhoto: Codable {
    let id, slug: String?
    let alternativeSlugs: AlternativeSlugs?
    let createdAt, updatedAt: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description: JSONNull?
    let altDescription: String?
    let breadcrumbs: [JSONAny]?
    let urls: Urls?
    let links: PhotoLinks?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [CurrentUserCollection]?
    let sponsorship: Sponsorship?
//    let topicSubmissions: TopicSubmissions?
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
//        case topicSubmissions = "topic_submissions"
        case assetType = "asset_type"
        case user
    }
}

struct Meta: Codable {
    let index: Bool?
}

struct RelatedCollections: Codable {
    let total: Int?
    let type: String?
    let results: [CollectionsResult]?
}

// MARK: - Result
struct CollectionsResult: Codable {
    let id, title: String?
    let description: JSONNull?
    let publishedAt, lastCollectedAt, updatedAt: Date?
    let featured: Bool?
    let totalPhotos: Int?
    let resultPrivate: Bool?
    let shareKey: String?
    let links: ResultLinks?
    let user: User?
    let coverPhoto: Photos?
    let previewPhotos: [PreviewPhoto]?

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case featured
        case totalPhotos = "total_photos"
        case resultPrivate = "private"
        case shareKey = "share_key"
        case links, user
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
    }
}
