//
//  Topics.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import Foundation

import Foundation

//// MARK: - Topics
//struct Topics: Codable {
//    let id: String?
//    let slug: String?
//    let title: String?
//    let description: String?
//    let publishedAt: Date?
//    let updatedAt: Date?
//    let startsAt: Date?
//    let endsAt: Date?
//    let onlySubmissionsAfter: Date?
//    let featured, totalPhotos: Int?
//    let links: Links?
//    let status: String?
//    let owners: [User]?
//    let coverPhoto: CoverPhoto?
//    let previewPhotos: [PreviewPhoto]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, slug, title, description
//        case publishedAt = "published_at"
//        case updatedAt = "updated_at"
//        case startsAt = "starts_at"
//        case endsAt = "ends_at"
//        case onlySubmissionsAfter = "only_submissions_after"
//        case featured
//        case totalPhotos = "total_photos"
//        case links, status, owners
//        case coverPhoto = "cover_photo"
//        case previewPhotos = "preview_photos"
//    }
//}
//
//// MARK: - Links
//struct Links: Codable {
//    let selfLink, html, photos: String?
//    let related: String?
//
//    enum CodingKeys: String, CodingKey {
//        case selfLink = "self"
//        case html, photos, related
//    }
//}
//
//// MARK: - CoverPhoto
//struct CoverPhoto: Codable {
//    let id: String?
//    let urls: Urls?
//}
//
//// MARK: - Urls
//struct Urls: Codable {
//    let raw, full, regular, small: String?
//    let thumb, smallS3: String?
//
//    enum CodingKeys: String, CodingKey {
//        case raw, full, regular, small, thumb
//        case smallS3 = "small_s3"
//    }
//}
//
//// MARK: - User
//struct User: Codable {
//    let id, username, name: String?
//    let firstName, lastName, twitterUsername: String?
//    let portfolioURL: String?
//    let bio, location: String?
//    let links: UserLinks?
//    let profileImage: ProfileImage?
//    let instagramUsername: String?
//    let totalCollections, totalLikes, totalPhotos: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, username, name
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case twitterUsername = "twitter_username"
//        case portfolioURL = "portfolio_url"
//        case bio, location, links
//        case profileImage = "profile_image"
//        case instagramUsername = "instagram_username"
//        case totalCollections = "total_collections"
//        case totalLikes = "total_likes"
//        case totalPhotos = "total_photos"
//    }
//}
//
//// MARK: - UserLinks
//struct UserLinks: Codable {
//    let selfLink, html, photos, likes: String?
//    let portfolio, following, followers: String?
//
//    enum CodingKeys: String, CodingKey {
//        case selfLink = "self"
//        case html, photos, likes, portfolio, following, followers
//    }
//}
//
//// MARK: - ProfileImage
//struct ProfileImage: Codable {
//    let small, medium, large: String?
//}
//
//// MARK: - PreviewPhoto
//struct PreviewPhoto: Codable {
//    let id: String?
//    let urls: Urls?
//}
